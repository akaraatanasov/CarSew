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
    
    var id: Int?
    var name: String?
    var price: Double?
    var type: ItemType?
    var color: ColorType?
    var employee: EmployeeResponse?
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

class CreateItemRequest: Codable {
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
    
    func toDictionary() -> [String: Any] {
        return ["name": name,
                "typeId": typeId,
                "colorId": colorId,
                "employeeId": employeeId,
                "price": price]
    }
}

class CreateItemResponse: Codable {
    var colors: [ColorType]?
    var types: [ItemType]?
    var employees: [EmployeeResponse]?
}

// for create item (for EmployeeResponse)
class ItemResponse: Codable {
    var id: Int?
    var name: String?
    var price: Double?
    var type: ItemType?
    var color: ColorType?
    var isProduced: Bool?
    var isSold: Bool?
}

// TODO: - Move this to Extensions file if such file becomes existant

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
