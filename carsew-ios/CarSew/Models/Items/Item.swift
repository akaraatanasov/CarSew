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
    var type: ItemType?
    var color: Color?
    var employee: Employee?
    var price: Double?
    
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
        return lhs.price! < rhs.price!
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id! == rhs.id!
    }
}
