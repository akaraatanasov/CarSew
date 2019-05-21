//
//  Item.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class Item: Codable {
    var id: Int?
    var name: String?
    var price: Double?
    var type: ItemType?
    var color: ColorType?
    var employee: Employee?
    var isProduced: Bool?
    var isSold: Bool?
    
    var cost: Double {
        let materialsPrice = type!.materialsPrice!
        let employeeSalary = employee!.salary!
        let itemsPerHour = employee!.experience!.itemsPerHour!

        return (materialsPrice + employeeSalary / Double(itemsPerHour)).rounded(toPlaces: 2)
    }

    var profit: Double {
        return (price! - cost).rounded(toPlaces: 2)
    }
}

class ItemCreate: Codable {
    var name: String
    var typeId: Int
    var colorId: Int
    var employeeId: Int
    var price: Double
    
    init(name: String, typeId: Int, colorId: Int, employeeId: Int, price: Double) {
        self.name = name
        self.typeId = typeId
        self.colorId = colorId
        self.employeeId = employeeId
        self.price = price
    }
}

class ItemProperties: Codable {
    var colors: [ColorType]?
    var types: [ItemType]?
    var employees: [Employee]?
}
