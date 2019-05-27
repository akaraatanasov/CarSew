//
//  AddItemViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func didCreateItem()
}

class AddItemViewController: UIViewController {
    
    var delegate: AddItemDelegate?
    
    // MARK: - Vars
    
    var itemTypes = [ItemType]()
    var colors = [ColorType]()
    var employees = [Employee]()
    
    var indicatorView: LoadingIndicator!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var employeeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    weak var pickerView: UIPickerView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getAllItemTypes()
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        indicatorView = LoadingIndicator(frame: view.frame)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        typeTextField.inputView = pickerView
        colorTextField.inputView = pickerView
        employeeTextField.inputView = pickerView
        
        typeTextField.delegate = self
        colorTextField.delegate = self
        employeeTextField.delegate = self
        
        self.pickerView = pickerView
    }
    
    private func getAllItemTypes() {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadItemProperties { [weak self] createItems, error in
            if let createItems = createItems {
                self?.itemTypes = createItems.types
                self?.colors = createItems.colors
                self?.employees = createItems.employees
                self?.indicatorView.hide()
                self?.pickerView?.reloadAllComponents()
            } else if let error = error, let strongSelf = self {
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    private func create(item itemToCreate: ItemCreate) {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.create(object: itemToCreate) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.indicatorView.hide()
                    self?.delegate?.didCreateItem()
                    self?.dismiss(animated: true)
                } else if let strongSelf = self {
                    self?.indicatorView.hide()
                    AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error",
                                                            andMessage: "The item you tried to add has some incorect info. Please check your inputs!")
                }
            }
        }
    }
    
    private func getItemFromInput() -> ItemCreate? {
        guard let name = nameTextField.text else { return nil }
        guard let typeName = typeTextField.text else { return nil }
        guard let colorName = colorTextField.text else { return nil }
        guard let employeeName = employeeTextField.text else { return nil }
        guard let priceString = priceTextField.text else { return nil }
        
        let type = itemTypes.first { $0.title == typeName }
        let color = colors.first { $0.name == colorName }
        let employee = employees.first { $0.name == employeeName }
        let optionalPrice = Double(priceString)
        
        guard let typeId = type?.id, let colorId = color?.id, let employeeId = employee?.id, let price = optionalPrice else { return nil }
        return ItemCreate(name: name, typeId: typeId, colorId: colorId, employeeId: employeeId, price: price)
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let itemToCreate = getItemFromInput() {
            create(item: itemToCreate)
        }
    }
    
}

// MARK: - Picker View Data Source

extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if typeTextField.isFirstResponder { return itemTypes.count }
        if colorTextField.isFirstResponder { return colors.count }
        if employeeTextField.isFirstResponder { return employees.count }
        
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if typeTextField.isFirstResponder { return itemTypes[row].title }
        if colorTextField.isFirstResponder { return colors[row].name }
        if employeeTextField.isFirstResponder { return employees[row].name }
        
        return nil
    }
}

// MARK: - Picker View Delegate

extension AddItemViewController: UIPickerViewDelegate {
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typeTextField.isFirstResponder { return typeTextField.text = itemTypes[row].title }
        if colorTextField.isFirstResponder { return colorTextField.text = colors[row].name }
        if employeeTextField.isFirstResponder { return employeeTextField.text = employees[row].name }
    }
}

// MARK: - Text Field Delegate

extension AddItemViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}
