//
//  ItemDetailsViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

protocol ItemDetailsDelegate {
    func didProduceItem(with id: Int)
}

class ItemDetailsViewController: UIViewController {
    
    var delegate: ItemDetailsDelegate?
    
    // MARK: - Vars
    
    var item: Item?
    
    var indicatorView: LoadingIndicator!
    
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
        
        setupView()
        displayItemDetails()
    }
    
    // MARK: - Private
    
    private func setupView() {
        indicatorView = LoadingIndicator(frame: view.frame)
    }
    
    private func displayItemDetails() {
        if let item = item {
            nameLabel.text = item.name
            typeLabel.text = item.type.title
            employeeLabel.text = item.employee?.name
            priceLabel.text = "\(item.price.rounded(toPlaces: 2))"
            colorView.backgroundColor = item.color.uiColor
        }
    }
    
    private func sendItemProduceRequest() {
        guard let itemId = item?.id else { return }
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.produceItem(with: itemId) { [weak self] success, error in
            if let success = success {
                if success {
                    self?.indicatorView.hide()
                    self?.delegate?.didProduceItem(with: itemId)
                    self?.navigationController?.popViewController(animated: true)
                } else if let strongSelf = self {
                    self?.indicatorView.hide()
                    AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error",
                                                            andMessage: "The item you tried to produce has already been produced!")
                }
            } else if let error = error, let strongSelf = self {
                self?.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func produceButtonTapped(_ sender: UIButton) {
        sendItemProduceRequest()
    }
    
}
