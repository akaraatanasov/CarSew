//
//  Color.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

enum Color: Int, Codable {
    case black = 1
    case white = 2
    case red = 3
    case green = 4
    case blue = 5
    case yellow = 6
    case brown = 7
    case purple = 9
    case pink = 10
    
    var uiColor: UIColor {
        switch self {
        case .black: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // (0, 0, 0)
        case .white: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // (255, 255, 255)
        case .red: return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // (255, 0, 0)
        case .green: return #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1) // (0, 255, 0)
        case .blue: return #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1) // (0, 0, 255)
        case .yellow: return #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1) // (255, 255, 0)
        case .brown: return #colorLiteral(red: 0.5450980392, green: 0.2705882353, blue: 0.07450980392, alpha: 1) // (139, 69, 19)
        case .purple: return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) // (142, 90, 247)
        case .pink: return #colorLiteral(red: 1, green: 0.6781052351, blue: 0.8084986806, alpha: 1) // (255, 173, 206)
        }
    }
}
