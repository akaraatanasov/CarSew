//
//  ColorType.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class ColorType: Codable {
    var id: Int
    var name: String
    
    var uiColor: UIColor {
        switch id {
        case 1: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // (0, 0, 0)
        case 2: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // (255, 255, 255)
        case 3: return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // (255, 0, 0)
        case 4: return #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1) // (0, 255, 0)
        case 5: return #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1) // (0, 0, 255)
        case 6: return #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1) // (255, 255, 0)
        case 7: return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) // (142, 90, 247)
        case 8: return #colorLiteral(red: 0.5450980392, green: 0.2705882353, blue: 0.07450980392, alpha: 1) // (139, 69, 19)
        case 9: return #colorLiteral(red: 1, green: 0.6781052351, blue: 0.8084986806, alpha: 1) // (255, 173, 206)
        default: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // (255, 255, 255)
        }
    }
}
