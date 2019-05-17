//
//  Item.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class Item: Codable {
    
    // MARK: - Vars
    
    var id: Int? // won't be optional when it comes from the back-end
    var name: String
    var type: ItemType
    var color: Color
    var employee: Employee
    var price: Double
    
    var cost: Double { // TODO: - Do this calculation on the backend
        let materialsPrice = type.materialsPrice
        let employeeSalary = employee.salary
        let itemsPerHour = employee.experience.itemsPerHour
        
        return (materialsPrice + employeeSalary / itemsPerHour).rounded(toPlaces: 2)
    }
    
    var profit: Double { // TODO: - Do this calculation on the backend
        return (price - cost).rounded(toPlaces: 2)
    }
    
    // MARK: - Inits
    
    init(name: String, type: ItemType, color: Color, employee: Employee, price: Double) {
        self.id = 0
        self.name = name
        self.type = type
        self.color = color
        self.employee = employee
        self.price = price
    }
}

extension Item: Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.price < rhs.price
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id! == rhs.id!
    }
}

// TODO: - Move this to Extensions file if such file becomes existant

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
