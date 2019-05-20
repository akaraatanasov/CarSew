//
//  EmployeeExperience.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class ExperienceType: Codable {
    var id: Int?
    var title: String?
    var itemsPerHour: Int?
}

enum EmployeeExperience: Int, Codable {
    case junior = 1
    case expert = 2
    
    var name: String {
        switch self {
        case .junior: return "Junior"
        case .expert: return "Expert"
        }
    }
    
    var itemsPerHour: Double {
        switch self {
        case .junior: return 2.0
        case .expert: return 3.0
        }
    }
}
