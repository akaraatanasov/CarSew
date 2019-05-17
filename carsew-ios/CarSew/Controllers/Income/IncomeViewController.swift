//
//  IncomeViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - Vars
    
    var overallIncome: Double? {
        didSet {
            if let overallIncome = overallIncome {
                overallIncomeLabel.text = "\(overallIncome.rounded(toPlaces: 2))"
            }
        }
    }
    
    var income = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var overallIncomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadIncome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reload table view
    }
    
    // MARK: - Private
    
    private func loadIncome() {
        // TODO: - Request income (overallIncome and income array) from back-end (GET)
        
        let theBest = Employee(name: "Ruler", experience: .expert, salary: 19.48)
        income.append(Item(name: "Mercedes seat", type: .seat, color: .brown, employee: theBest, price: 349.34))
        income.append(Item(name: "BMW backrest", type: .backrest, color: .red, employee: theBest, price: 832.23))
        income.append(Item(name: "Volvo handle", type: .doorhandle, color: .purple, employee: theBest, price: 349.34))
        income.append(Item(name: "BMW steering wheel", type: .wheel, color: .pink, employee: theBest, price: 349.34))
        income.append(Item(name: "Mazda headrest", type: .other, color: .yellow, employee: theBest, price: 349.34))
    }
    
}

// MARK: - Table View Data Source

extension IncomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return income.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath)
        let currentItem = income[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = "+\(currentItem.price)" // TODO: - Make this green
        
        return cell
    }
}
