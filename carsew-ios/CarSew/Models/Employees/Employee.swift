//
//  Employee.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class Employee: Codable {
    
    // MARK: - Vars
    
    var id: Int?
    var name: String?
    var experience: EmployeeExperience?
    var salary: Double?
    var items: [Item]?
    
    // MARK: - Inits
    
    init(name: String, experience: EmployeeExperience, salary: Double) {
        self.id = 0
        self.name = name
        self.experience = experience
        self.salary = salary
        self.items = [Item]()
    }
    
    // MARK: - Public
    
    func addItem(item: Item) {
        items?.append(item)
    }
    
    func removeItem(item: Item) {
        if let itemToRemoveIndex = items?.firstIndex(of: item) {
            items?.remove(at: itemToRemoveIndex)
        }   
    }
}
