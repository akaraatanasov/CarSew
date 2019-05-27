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
                overallAccountingLabel.text = "\(overallAccounting.rounded(toPlaces: 2))"
            }
        }
    }
    
    var accountingItems = [Item]()
    
    var indicatorView: LoadingIndicator!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var overallAccountingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAccounting()
    }
    
    // MARK: - Private
    
    private func setupView() {
        indicatorView = LoadingIndicator(frame: view.frame)
    }
    
    private func loadAccounting() {
        switch navigationController?.tabBarItem.tag {
        case 3:
            title = "Expenses"
            loadExpenses()
        case 4:
            title = "Income"
            loadIncome()
        case 5:
            title = "Profit"
            loadProfit()
        default: break
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
    
    // MARK: - Requests
    
    private func loadExpenses() {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadExpenses { [weak self] expenses, error in
            if let expenses = expenses {
                self?.overallAccounting = expenses.overall
                self?.accountingItems = expenses.items
                self?.indicatorView.hide()
                self?.tableView.reloadData()
            } else if let error = error, let strongSelf = self {
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    private func loadIncome() {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadIncome { [weak self] income, error in
            if let income = income {
                self?.overallAccounting = income.overall
                self?.accountingItems = income.items
                self?.indicatorView.hide()
                self?.tableView.reloadData()
            } else if let error = error, let strongSelf = self {
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    private func loadProfit() {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadProfit { [weak self] profit, error in
            if let profit = profit {
                self?.overallAccounting = profit.overall
                self?.accountingItems = profit.items
                self?.indicatorView.hide()
                self?.tableView.reloadData()
            } else if let error = error, let strongSelf = self {
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    private func sendItemSellRequest(with itemId: Int) {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.sellItem(with: itemId) { [weak self] success, error in
            if let success = success {
                if success {
                    self?.indicatorView.hide()
                    self?.loadExpenses()
                } else if let strongSelf = self {
                    strongSelf.indicatorView.hide()
                    AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: "The item you tried to sell has already been sold!")
                }
            } else if let error = error, let strongSelf = self { // TODO: - ASK Victor if there is any point of calling main.async in showAlert ...
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountingCell", for: indexPath)
        let currentItem = accountingItems[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = "\(currentItem.cost)"
        
        return cell
    }
}

// MARK: - Table View Delegate

extension AccountingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if navigationController?.tabBarItem.tag == 3 { // expenses
            let selectedItemId = accountingItems[indexPath.row].id
            sellItem(with: selectedItemId)
        }
    }
}
