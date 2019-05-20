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
                DispatchQueue.main.async { [weak self] in
                    self?.overallIncomeLabel.text = "\(overallIncome.rounded(toPlaces: 2))"
                }
            }
        }
    }
    
    var income = [Item]()
    
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
        
        loadIncome()
    }
    
    // MARK: - Private
    
    private func loadIncome() {
        // show loading indicator
        NetworkManager.sharedInstance.loadIncome { [weak self] income in
            if let overallIncome = income.overall, let incomeItems = income.items {
                self?.overallIncome = overallIncome
                self?.income = incomeItems
                
                DispatchQueue.main.async { [weak self] in
                    // hide loading indicator
                    self?.tableView.reloadData()
                }
            }
        }
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
        cell.detailTextLabel?.text = "+\(currentItem.price!)" // TODO: - Make this green
        
        return cell
    }
}
