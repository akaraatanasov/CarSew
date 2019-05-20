//
//  EmployeeDetailsViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
    
    // MARK: - Vars
    
    var employee: EmployeeResponse?
    var employeeItems = [ItemResponse]()
    
    var selectedItem: ItemResponse?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayEmployeeDetails()
        loadEmployeeDetails()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "showItemDetailsFromEmployee":
//            if let itemDetailsViewController = segue.destination as? ItemDetailsViewController {
//                itemDetailsViewController.item = selectedItem
//            }
//        default: break
//        }
    }
    
    // MARK: - Private
    
    private func displayEmployeeDetails() {
        if let employee = employee {
            nameLabel.text = employee.name
            experienceLabel.text = employee.experience?.title
            salaryLabel.text = "\(employee.salary ?? 0)"
        }
    }
    
    private func loadEmployeeDetails() {
        // TODO: - Request employee details (mainly items) by id (GET)
        guard let employeeId = employee?.id else { return }
        NetworkManager.sharedInstance.loadEmployeeDetails(with: employeeId) { [weak self] employee in
            if let employeeItems = employee.itemList {
                self?.employeeItems = employeeItems
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}

// MARK: - Table View Data Source

extension EmployeeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeItemCell", for: indexPath)
        let currentItem = employeeItems[indexPath.row]
        
        cell.textLabel?.text = currentItem.name
        cell.detailTextLabel?.text = currentItem.type?.title
        cell.backgroundColor = Color(rawValue: currentItem.color!.id!)?.uiColor
        
        return cell
    }
}

extension EmployeeDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedItem = employeeItems[indexPath.row]
        performSegue(withIdentifier: "showItemDetailsFromEmployee", sender: self)
    }
}
