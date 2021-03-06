//
//  ItemsViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    
    // MARK: - Vars
    
    var items = [Item]()
    
    var selectedItem: Item?
    
    var indicatorView: LoadingIndicator!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadItems()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAddItem":
            if let addItemViewController = segue.destination as? AddItemViewController {
                addItemViewController.delegate = self
            }
        case "showItemDetails":
            if let itemDetailsViewController = segue.destination as? ItemDetailsViewController {
                itemDetailsViewController.delegate = self
                itemDetailsViewController.item = selectedItem
            }
        default: break
        }
    }
    
    // MARK: - Private
    
    
    private func setupView() {
        indicatorView = LoadingIndicator(frame: view.frame)
    }
    
    private func loadItems() {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadItems { [weak self] items, error in
            if let items = items {
                self?.items = items
                self?.indicatorView.hide()
                self?.tableView.reloadData()
            } else if let error = error, let strongSelf = self {
                self?.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }

}

// MARK: - Table View Data Source

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let currentItem = items[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = currentItem.type.title
        cell.backgroundColor = currentItem.color.uiColor
        
        return cell
    }
}

// MARK: - Table View Delegate

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedItem = items[indexPath.row]
        performSegue(withIdentifier: "showItemDetails", sender: self)
    }
}

// MARK: - Add Item Delegate

extension ItemsViewController: AddItemDelegate {
    func didCreateItem() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            sleep(1) // backend is too slow to respond, waiting 1 second before listing all items again
            DispatchQueue.main.async {
                self?.loadItems()
            }
        }
    }
}

// MARK: - Item Details Delegate

extension ItemsViewController: ItemDetailsDelegate {
    func didProduceItem(with id: Int) {
        items.removeAll { $0.id == id }
        tableView.reloadData()
    }
}
