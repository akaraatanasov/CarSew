//
//  EmployeeExperience.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

enum EmployeeExperience: Int, Codable {
    case junior = 1
    case expert = 2
    
    var itemsPerHour: Int {
        switch self {
        case .junior: return 2
        case .expert: return 3
        }
    }
}
