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
            typeLabel.text = item.type.name
            employeeLabel.text = item.employee.name
            priceLabel.text = "\(item.price.rounded(toPlaces: 2))"
            colorView.backgroundColor = item.color.uiColor
        }
    }
    
    private func sendItemProduceRequest() {
        // TODO: - Send item produce request with item id (POST)
        
        print("Proooduuuciiiing")
    }
    
    // MARK: - IBActions
    
    @IBAction func produceButtonTapped(_ sender: UIButton) {
        sendItemProduceRequest()
    }
    
}
