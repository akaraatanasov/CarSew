//
//  Employee.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class Employee: Codable {
    var id: Int
    var name: String
    var salary: Double
    var experience: ExperienceType
    var itemList: [Item]?
}

class EmployeeCreate: Codable {
    var name: String
    var salary: Double
    var experienceId: Int
    
    init(name: String, salary: Double, experienceId: Int) {
        self.name = name
        self.salary = salary
        self.experienceId = experienceId
    }
}
