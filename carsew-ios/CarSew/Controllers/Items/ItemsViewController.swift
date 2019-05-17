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
    
    var items = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reload table view
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Private
    
    private func loadItems() {
        // request items from back-end
        let theBest = Employee(name: "Ruler", experience: .expert, salary: 19.48)
        items.append(Item(name: "Mercedes seat", type: .seat, color: .brown, employee: theBest, price: 349.34))
        items.append(Item(name: "BMW backrest", type: .backrest, color: .red, employee: theBest, price: 832.23))
        items.append(Item(name: "Volvo handle", type: .doorhandle, color: .purple, employee: theBest, price: 349.34))
        items.append(Item(name: "BMW steering wheel", type: .wheel, color: .pink, employee: theBest, price: 349.34))
        items.append(Item(name: "Mazda headrest", type: .other, color: .yellow, employee: theBest, price: 349.34))
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
        cell.detailTextLabel?.text = currentItem.type?.name
        cell.backgroundColor = currentItem.color?.uiColor
        
        return cell
    }
}

// MARK: - Table View Delegate

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected row: \(indexPath.row)")
    }
}
