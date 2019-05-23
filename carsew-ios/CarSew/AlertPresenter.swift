//
//  AlertPresenter.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 23.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class AlertPresenter {
    
    static let sharedInstance = AlertPresenter()
    
    func showAlert(from sender: UIViewController, withTitle title: String, andMessage message: String, buttonHandler handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        
        DispatchQueue.main.async {
            sender.present(alertController, animated: true)
        }
    }
    
}
