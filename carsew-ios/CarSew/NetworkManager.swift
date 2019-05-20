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
    
    func loadItemCreate(completionHandler: @escaping (_ types: CreateItemResponse) -> ()) {
        let path = "item/create"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonCreateItemResponse = try? JSONDecoder().decode(CreateItemResponse.self, from: data) {
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
    
    func loadEmployees(completionHandler: @escaping (_ employees: [EmployeeResponse]) -> ()) {
        let path = "employee/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonEmployees = try? JSONDecoder().decode([EmployeeResponse].self, from: data) {
                        completionHandler(jsonEmployees)
                    }
                    return
                }
            }
            
            // show error message
        }
    }
    
    func loadEmployeeCreate(completionHandler: @escaping (_ experienceTypes: [ExperienceType]) -> ()) {
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
    
    func loadEmployeeDetails(with employeeId: Int, completionHandler: @escaping (_ employee: EmployeeResponse) -> ()) {
        let path = "employee/\(employeeId)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonEmployee = try? JSONDecoder().decode(EmployeeResponse.self, from: data) {
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
    
    func create(item: CreateItemRequest, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = "item/create"
        let urlString = baseUrl + path
        
        let jsonData = try? JSONSerialization.data(withJSONObject: item.toDictionary())
//        let jsonData = try? JSONEncoder.encode(jsonItem)
        
        // create post request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        
        // insert json data to the request
        request.httpBody = jsonData
        
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
    
    func create(employee: CreateEmployeeRequest, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = "employee/create"
        let urlString = baseUrl + path
        
        let jsonData = try? JSONSerialization.data(withJSONObject: employee.toDictionary())
        //        let jsonData = try? JSONEncoder.encode(jsonItem)
        
        // create post request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        
        // insert json data to the request
        request.httpBody = jsonData
        
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
