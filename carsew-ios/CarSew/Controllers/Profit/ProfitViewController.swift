//
//  ProfitViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class ProfitViewController: UIViewController {
    
    // MARK: - Vars
    
    var overallProfit: Double? {
        didSet {
            if let overallProfit = overallProfit {
                overallProfitLabel.text = "\(overallProfit.rounded(toPlaces: 2))"
            }
        }
    }
    
    var profit = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var overallProfitLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reload table view
    }
    
    // MARK: - Private
    
    private func loadProfit() {
        // TODO: - Request profit (overallProfit and profit array) from back-end (GET)
        
        let theBest = Employee(name: "Ruler", experience: .expert, salary: 19.48)
        profit.append(Item(name: "Mercedes seat", type: .seat, color: .brown, employee: theBest, price: 349.34))
        profit.append(Item(name: "BMW backrest", type: .backrest, color: .red, employee: theBest, price: 832.23))
        profit.append(Item(name: "Volvo handle", type: .doorhandle, color: .purple, employee: theBest, price: 349.34))
        profit.append(Item(name: "BMW steering wheel", type: .wheel, color: .pink, employee: theBest, price: 349.34))
        profit.append(Item(name: "Mazda headrest", type: .other, color: .yellow, employee: theBest, price: 349.34))
    }
    
}

// MARK: - Table View Data Source

extension ProfitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profitCell", for: indexPath)
        let currentItem = profit[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = "+\(currentItem.profit)" // TODO: - Make this green
        
        return cell
    }
}
