//
//  AccountingViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 23.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class AccountingViewController: UIViewController {

    // MARK: - Vars
    
    var overallAccounting: Double? {
        didSet {
            if let overallAccounting = overallAccounting {
                DispatchQueue.main.async { [weak self] in
                    self?.overallAccountingLabel.text = "\(overallAccounting.rounded(toPlaces: 2))"
                }
            }
        }
    }
    
    var accountingItems = [Item]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var overallAccountingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAccounting()
    }
    
    // MARK: - Private
    
    private func loadAccounting() {
        if let selectedTabIndex = tabBarController?.selectedIndex {
            switch selectedTabIndex {
            case 2: loadExpenses()
            case 3: loadIncome()
            case 4: loadProfit()
            default: break
            }
        }
    }
    
    private func presentErrorAlert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "The item you tried to sell has already been sold!",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
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
    
    // MARK: - Requests
    
    private func loadExpenses() {
        // show loading indicator
        NetworkManager.sharedInstance.loadExpenses { [weak self] expenses in
            self?.overallAccounting = expenses.overall
            self?.accountingItems = expenses.items
            
            DispatchQueue.main.async { [weak self] in
                // hide loading indicator
                self?.tableView.reloadData()
            }
        }
    }
    
    private func loadIncome() {
        // show loading indicator
        NetworkManager.sharedInstance.loadIncome { [weak self] income in
            self?.overallAccounting = income.overall
            self?.accountingItems = income.items
            
            DispatchQueue.main.async { [weak self] in
                // hide loading indicator
                self?.tableView.reloadData()
            }
        }
    }
    
    private func loadProfit() {
        // show loading indicator
        NetworkManager.sharedInstance.loadProfit { [weak self] profit in
            self?.overallAccounting = profit.overall
            self?.accountingItems = profit.items
            
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

}

// MARK: - Table View Data Source

extension AccountingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expensesCell", for: indexPath)
        let currentItem = accountingItems[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = "-\(currentItem.cost)"
        
        return cell
    }
}

// MARK: - Table View Delegate

extension AccountingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tabBarController?.selectedIndex == 2 { // expenses
            let selectedItemId = accountingItems[indexPath.row].id
            sellItem(with: selectedItemId)
        }
    }
}
