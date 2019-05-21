//
//  Extensions.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 21.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Encodable {
    func data(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
    func string(using encoder: JSONEncoder = JSONEncoder()) throws -> String {
        return try String(data: encoder.encode(self), encoding: .utf8)!
    }
}
