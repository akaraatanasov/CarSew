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
    
    var employee: Employee?
    var employeeItems = [Item]()
    
    var selectedItem: Item?
    
    var indicatorView: LoadingIndicator!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        displayEmployeeDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    private func setupView() {
        indicatorView = LoadingIndicator(frame: view.frame)
    }
    
    private func displayEmployeeDetails() {
        if let employee = employee {
            nameLabel.text = employee.name
            experienceLabel.text = employee.experience.title
            salaryLabel.text = "\(employee.salary)"
        }
    }
    
    private func loadEmployeeDetails() {
        guard let employeeId = employee?.id else { return }
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadEmployeeDetails(with: employeeId) { [weak self] employee, error in
            if let employeeItems = employee?.itemList {
                self?.employeeItems = employeeItems
                self?.indicatorView.hide()
                self?.tableView.reloadData()
            } else if let error = error, let strongSelf = self {
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
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
        cell.detailTextLabel?.text = currentItem.type.title
        cell.backgroundColor = currentItem.color.uiColor
        
        return cell
    }
}

extension EmployeeDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedItem = employeeItems[indexPath.row]
//        performSegue(withIdentifier: "showItemDetailsFromEmployee", sender: self)
    }
}
