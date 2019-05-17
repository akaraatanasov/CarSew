//
//  ItemType.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

enum ItemType: Int, Codable {
    case seat = 1
    case backrest = 2
    case wheel = 3
    case doorhandle = 4
    case other = 5
    
    var name: String {
        switch self {
        case .seat: return "Seat"
        case .backrest: return "Backrest"
        case .wheel: return "Steering wheel"
        case .doorhandle: return "Doorhandle"
        case .other: return "Other"
        }
    }
    
    var materialsPrice: Double {
        switch self {
        case .seat: return 150.00
        case .backrest: return 25.00
        case .wheel: return 60.00
        case .doorhandle: return 19.00
        case .other: return 50.00
        }
    }
}
