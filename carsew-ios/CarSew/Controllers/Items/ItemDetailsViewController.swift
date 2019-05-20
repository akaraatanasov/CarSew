//
//  ItemDetailsViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    // MARK: - Vars
    
    var item: Item?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var employeeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorView: UIView! {
        didSet {
            colorView.layer.cornerRadius = colorView.frame.width / 2
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayItemDetails()
    }
    
    // MARK: - Private
    
    private func displayItemDetails() {
        if let item = item {
            nameLabel.text = item.name
            typeLabel.text = item.type?.title
            employeeLabel.text = item.employee?.name
            priceLabel.text = "\(item.price!.rounded(toPlaces: 2))"
            colorView.backgroundColor = Color(rawValue: item.color!.id!)?.uiColor
        }
    }
    
    private func presentErrorAlert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "The item you tried to produce has already been produced!",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    private func presentSuccessAlert() {
        let alertController = UIAlertController(title: "Success",
                                                message: "The item was produced successfully!",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    private func sendItemProduceRequest() {
        guard let itemId = item?.id else { return }
        NetworkManager.sharedInstance.produceItem(with: itemId) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.presentErrorAlert()
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func produceButtonTapped(_ sender: UIButton) {
        sendItemProduceRequest()
    }
    
}
