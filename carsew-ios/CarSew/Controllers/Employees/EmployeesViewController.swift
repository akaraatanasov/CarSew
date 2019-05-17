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
    
    var employees = [Employee]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedEmployee: Employee?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEmployees()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reload table view
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showEmployeeDetails":
            if let employeeDetailsViewController = segue.destination as? EmployeeDetailsViewController {
                employeeDetailsViewController.employee = selectedEmployee
            }
        default: break
        }
    }
    
    // MARK: - Private
    
    private func loadEmployees() {
        // TODO: - Request employees from back-end
        
        employees.append(Employee(name: "Ruler", experience: .expert, salary: 19.48))
        employees.append(Employee(name: "Greeny", experience: .junior, salary: 9.53))
        employees.append(Employee(name: "Sammy", experience: .junior, salary: 12.86))
        employees.append(Employee(name: "Peter", experience: .expert, salary: 25.53))
        employees.append(Employee(name: "Simona", experience: .junior, salary: 14.53))
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
        cell.detailTextLabel?.text = currentEmployee.experience.name
        
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
