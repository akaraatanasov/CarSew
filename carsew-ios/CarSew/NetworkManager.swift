//
//  NetworkManager.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 20.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    // MARK: - Vars
    
    let baseUrl = "http://localhost:8089/"
    
    // MARK: - Public
    
    // MARK: - GET
    
    func loadItems(completionHandler: @escaping (_ items: [Item]) -> ()) {
        let path = "item/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonItems = try? JSONDecoder().decode([Item].self, from: data) {
                        completionHandler(jsonItems)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadItemProperties(completionHandler: @escaping (_ types: ItemProperties) -> ()) {
        let path = "item/create"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonCreateItemResponse = try? JSONDecoder().decode(ItemProperties.self, from: data) {
                        completionHandler(jsonCreateItemResponse)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func produceItem(with id: Int, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = "item/produce/\(id)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonSuccess = try? JSONDecoder().decode(SuccessType.self, from: data) {
                        if let success = jsonSuccess.success {
                            completionHandler(success)
                        }
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func sellItem(with id: Int, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = "item/sell/\(id)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonSuccess = try? JSONDecoder().decode(SuccessType.self, from: data) {
                        if let success = jsonSuccess.success {
                            completionHandler(success)
                        }
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadEmployees(completionHandler: @escaping (_ employees: [Employee]) -> ()) {
        let path = "employee/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonEmployees = try? JSONDecoder().decode([Employee].self, from: data) {
                        completionHandler(jsonEmployees)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadEmployeeProperties(completionHandler: @escaping (_ experienceTypes: [ExperienceType]) -> ()) {
        let path = "employee/create"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonCreateEmployeeResponse = try? JSONDecoder().decode([ExperienceType].self, from: data) {
                        completionHandler(jsonCreateEmployeeResponse)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadEmployeeDetails(with employeeId: Int, completionHandler: @escaping (_ employee: Employee) -> ()) {
        let path = "employee/\(employeeId)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonEmployee = try? JSONDecoder().decode(Employee.self, from: data) {
                        completionHandler(jsonEmployee)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadExpenses(completionHandler: @escaping (_ expenses: Accounting) -> ()) {
        let path = "expense/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonExpenses = try? JSONDecoder().decode(Accounting.self, from: data) {
                        completionHandler(jsonExpenses)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadIncome(completionHandler: @escaping (_ income: Accounting) -> ()) {
        let path = "income/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonIncome = try? JSONDecoder().decode(Accounting.self, from: data) {
                        completionHandler(jsonIncome)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadProfit(completionHandler: @escaping (_ profit: Accounting) -> ()) {
        let path = "profit/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonProfit = try? JSONDecoder().decode(Accounting.self, from: data) {
                        completionHandler(jsonProfit)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    // MARK: - POST
    
    func create(item: ItemCreate, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = "item/create"
        let urlString = baseUrl + path
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        request.httpBody = try? item.data()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false)
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completionHandler(false)
                print(responseJSON)
            }
        }
        
        task.resume()
        completionHandler(true)
    }
    
    func create(employee: EmployeeCreate, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = "employee/create"
        let urlString = baseUrl + path
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        request.httpBody = try? employee.data()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false)
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completionHandler(false)
                print(responseJSON)
            }
        }
        
        task.resume()
        completionHandler(true)
    }
    
}
