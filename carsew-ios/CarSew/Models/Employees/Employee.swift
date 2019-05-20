//
//  Employee.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class Employee: Codable {
    var id: Int?
    var name: String?
    var salary: Double?
    var experience: ExperienceType?
    var items: [Item]?
}

class CreateEmployeeRequest: Codable {
    var name: String
    var salary: Double
    var experienceId: Int
    
    
    init(name: String, salary: Double, experienceId: Int) {
        self.name = name
        self.salary = salary
        self.experienceId = experienceId
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name,
                "salary": salary,
                "experienceId": experienceId]
    }
}

class EmployeeResponse: Codable {
    var id: Int?
    var name: String?
    var salary: Double?
    var experience: ExperienceType?
    var itemList: [ItemResponse]?
}
