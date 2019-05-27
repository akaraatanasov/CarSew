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
    
    func loadItems(completionHandler: @escaping (_ items: [Item]?, _ error: Error?) -> ()) {
        let path = "item/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonItems = try? JSONDecoder().decode([Item].self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonItems, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing items was unsuccessful"))
            }
        }
    }
    
    func loadItemProperties(completionHandler: @escaping (_ types: ItemProperties?, _ error: Error?) -> ()) {
        let path = "item/create"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonCreateItemResponse = try? JSONDecoder().decode(ItemProperties.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonCreateItemResponse, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing item create types was unsuccessful"))
            }
        }
    }
    
    func produceItem(with id: Int, completionHandler: @escaping (_ success: Bool?, _ error: Error?) -> ()) {
        let path = "item/produce/\(id)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let json = try? JSONDecoder().decode(SuccessType.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(json.success, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Producing item was unsuccessful"))
            }
        }
    }
    
    func sellItem(with id: Int, completionHandler: @escaping (_ success: Bool?, _ error: Error?) -> ()) {
        let path = "item/sell/\(id)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let json = try? JSONDecoder().decode(SuccessType.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(json.success, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Producing item was unsuccessful"))
            }
        }
    }
    
    func loadEmployees(completionHandler: @escaping (_ employees: [Employee]?, _ error: Error?) -> ()) {
        let path = "employee/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonEmployees = try? JSONDecoder().decode([Employee].self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonEmployees, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing employees was unsuccessful"))
            }
        }
    }
    
    func loadEmployeeProperties(completionHandler: @escaping (_ experienceTypes: [ExperienceType]?, _ error: Error?) -> ()) {
        let path = "employee/create"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonCreateEmployeeResponse = try? JSONDecoder().decode([ExperienceType].self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonCreateEmployeeResponse, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing employee create types was unsuccessful"))
            }
        }
    }
    
    func loadEmployeeDetails(with employeeId: Int, completionHandler: @escaping (_ employee: Employee?, _ error: Error?) -> ()) {
        let path = "employee/\(employeeId)"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonEmployee = try? JSONDecoder().decode(Employee.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonEmployee, nil)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing employee details was unsuccessful"))
            }
        }
    }
    
    func loadExpenses(completionHandler: @escaping (_ expenses: Accounting?, _ error: Error?) -> ()) {
        let path = "expense/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonExpenses = try? JSONDecoder().decode(Accounting.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonExpenses, nil)
                        }
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing expenses was unsuccessful"))
            }
        }
    }
    
    func loadIncome(completionHandler: @escaping (_ income: Accounting?, _ error: Error?) -> ()) {
        let path = "income/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonIncome = try? JSONDecoder().decode(Accounting.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonIncome, nil)
                        }
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing income was unsuccessful"))
            }
        }
    }
    
    func loadProfit(completionHandler: @escaping (_ profit: Accounting?, _ error: Error?) -> ()) {
        let path = "profit/list"
        let urlString = baseUrl + path
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let jsonProfit = try? JSONDecoder().decode(Accounting.self, from: data) {
                        sleep(2)
                        DispatchQueue.main.async {
                            completionHandler(jsonProfit, nil)
                        }
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(nil, ErrorType(description: "Listing profit was unsuccessful"))
            }
        }
    }
    
    // MARK: - POST
    
    func create<T: Encodable>(object: T, completionHandler: @escaping (_ success: Bool) -> ()) {
        let path = object is ItemCreate ? "item/create" : "employee/create"
        let urlString = baseUrl + path
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        request.httpBody = try? object.data()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false)
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            }
        }
        
        task.resume()
//        DispatchQueue.main.async {
//            completionHandler(true)
//        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(2)
            DispatchQueue.main.async {
                completionHandler(true)
            }
        }
    }
    
}
