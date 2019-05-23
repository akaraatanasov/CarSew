//
//  EmployeesViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    // MARK: - Vars
    
    var employees = [Employee]()
    
    var selectedEmployee: Employee?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEmployees()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAddEmployee":
            if let addEmployeeViewController = segue.destination as? AddEmployeeViewController {
                addEmployeeViewController.delegate = self
            }
        case "showEmployeeDetails":
            if let employeeDetailsViewController = segue.destination as? EmployeeDetailsViewController {
                employeeDetailsViewController.employee = selectedEmployee
            }
        default: break
        }
    }
    
    // MARK: - Private
    
    private func loadEmployees() {
        // show loading indicator
        NetworkManager.sharedInstance.loadEmployees { [weak self] employees, error in
            if let employees = employees {
                self?.employees = employees
                
                DispatchQueue.main.async { [weak self] in
                    // hide loading indicator
                    self?.tableView.reloadData()
                }
            } else if let error = error, let strongSelf = self {
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        } 
    }
    
}

// MARK: - Table View Data Source

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        let currentEmployee = employees[indexPath.row]
        
        cell.textLabel?.text = currentEmployee.name
        cell.detailTextLabel?.text = currentEmployee.experience.title
        
        return cell
    }
}

// MARK: - Table View Delegate

extension EmployeesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedEmployee = employees[indexPath.row]
        performSegue(withIdentifier: "showEmployeeDetails", sender: self)
    }
}

// MARK: - Add Employee Delegate

extension EmployeesViewController: AddEmployeeDelegate {
    func didCreateEmployee() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            sleep(1)
            self?.loadEmployees()
        }
    }
}
