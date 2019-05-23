//
//  ErrorType.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 23.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class ErrorType: Error {
    var localizedDescription: String
    
    init(description: String) {
        localizedDescription = description
    }
}
