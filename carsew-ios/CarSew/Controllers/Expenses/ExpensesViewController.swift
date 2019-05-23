//
//  ExpensesViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {
    
    // MARK: - Vars
    
    var overallExpenses: Double? {
        didSet {
            if let overallExpenses = overallExpenses {
                DispatchQueue.main.async { [weak self] in
                    self?.overallExpensesLabel.text = "\(overallExpenses.rounded(toPlaces: 2))"
                }
            }
        }
    }
    
    var expenses = [Item]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var overallExpensesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadExpenses()
    }
    
    // MARK: - Private
    
    private func presentErrorAlert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "The item you tried to sell has already been sold!",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    private func loadExpenses() {
        // show loading indicator
        NetworkManager.sharedInstance.loadExpenses { [weak self] expenses in
            self?.overallExpenses = expenses.overall
            self?.expenses = expenses.items
            
            DispatchQueue.main.async { [weak self] in
                // hide loading indicator
                self?.tableView.reloadData()
            }
        }
    }
    
    private func sendItemSellRequest(with itemId: Int) {
        NetworkManager.sharedInstance.sellItem(with: itemId) { [weak self] success in
            if success {
                self?.loadExpenses()
            } else {
                DispatchQueue.main.async {
                    self?.presentErrorAlert()
                }
            }
        }
    }
    
    private func sellItem(with id: Int) {
        let alertController = UIAlertController(title: "Sell this item?",
                                                message: "Are you sure you want to sell this item?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default))
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
            self?.sendItemSellRequest(with: id)
        }))
        present(alertController, animated: true)
    }
    
}

// MARK: - Table View Data Source

extension ExpensesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expensesCell", for: indexPath)
        let currentItem = expenses[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = "-\(currentItem.cost)" // TODO: - Make this red
        
        return cell
    }
}

// MARK: - Table View Delegate

extension ExpensesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItemId = expenses[indexPath.row].id
        sellItem(with: selectedItemId)
    }
}
