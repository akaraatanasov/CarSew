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
                overallExpensesLabel.text = "\(overallExpenses.rounded(toPlaces: 2))"
            }
        }
    }
    
    var expenses = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var overallExpensesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadExpenses()
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
    
    private func loadExpenses() {
        // TODO: - Request expenses (overallExpenses and expenses array) from back-end (GET)
        
        let theBest = Employee(name: "Ruler", experience: .expert, salary: 19.48)
        expenses.append(Item(name: "Mercedes seat", type: .seat, color: .brown, employee: theBest, price: 349.34))
        expenses.append(Item(name: "BMW backrest", type: .backrest, color: .red, employee: theBest, price: 832.23))
        expenses.append(Item(name: "Volvo handle", type: .doorhandle, color: .purple, employee: theBest, price: 349.34))
        expenses.append(Item(name: "BMW steering wheel", type: .wheel, color: .pink, employee: theBest, price: 349.34))
        expenses.append(Item(name: "Mazda headrest", type: .other, color: .yellow, employee: theBest, price: 349.34))
    }
    
    private func sellItem(with id: Int) {
        let alertController = UIAlertController(title: "Sell this item?",
                                                message: "Are you sure you want to sell this item?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default))
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            // TODO: - Send request to back-end to sell this item (by sending it's id) (POST)
            
            // if success -> loadExpenses()
            // else -> show error
            
            print("Selling item with id: \(id)")
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
        
        let selectedItemId = expenses[indexPath.row].id!
        sellItem(with: selectedItemId)
    }
}
