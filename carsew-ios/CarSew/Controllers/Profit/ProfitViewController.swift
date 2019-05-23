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
                DispatchQueue.main.async { [weak self] in
                    self?.overallProfitLabel.text = "\(overallProfit.rounded(toPlaces: 2))"
                }
            }
        }
    }
    
    var profit = [Item]()
    
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
        
        loadProfit()
    }
    
    // MARK: - Private
    
    private func loadProfit() {
        // show loading indicator
        NetworkManager.sharedInstance.loadProfit { [weak self] profit in
            self?.overallProfit = profit.overall
            self?.profit = profit.items
            
            DispatchQueue.main.async { [weak self] in
                // hide loading indicator
                self?.tableView.reloadData()
            }
        }
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
