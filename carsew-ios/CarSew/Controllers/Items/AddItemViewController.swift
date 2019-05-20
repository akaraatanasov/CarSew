//
//  AddItemViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    // MARK: - Vars
    
    var itemTypes = [ItemType]()
    var colors = [ColorType]()
    var employees = [EmployeeResponse]()
    
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
        getAllItemTypes()
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
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
        // show loading indicator
        NetworkManager.sharedInstance.loadItemCreate { [weak self] createItems in
            if let itemTypes = createItems.types, let colors = createItems.colors, let employees = createItems.employees {
                self?.itemTypes = itemTypes
                self?.colors = colors
                self?.employees = employees
                
                DispatchQueue.main.async {
                    // hide loading indicator
                    self?.pickerView?.reloadAllComponents()
                }
            } else {
                // hide loading indicator
                // show error
            }
        }
    }
    
    private func getItemFromInput() -> CreateItemRequest? {
        guard let name = nameTextField.text else { return nil }
        guard let typeName = typeTextField.text else { return nil }
        guard let colorName = colorTextField.text else { return nil }
        guard let employeeName = employeeTextField.text else { return nil }
        guard let priceString = priceTextField.text else { return nil }
        
        let type = itemTypes.first { $0.title == typeName }
        let color = colors.first { $0.name == colorName }
        let employee = employees.first { $0.name == employeeName }
        let price = Double(priceString)
        
        if let typeId = type?.id, let colorId = color?.id, let employeeId = employee?.id, let price = price {
            return CreateItemRequest(name: name, typeId: typeId, colorId: colorId, employeeId: employeeId, price: price)
        } else {
            return nil
        }
    }
    
    private func presentErrorAlert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "The item you tried to add has some incorect info. Please check your inputs!",
                                                preferredStyle: .alert)
    
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let itemToSend = getItemFromInput() {
            NetworkManager.sharedInstance.create(item: itemToSend) { [weak self] success in
                print(success)
                
                DispatchQueue.main.async {
                    if success {
                        self?.dismiss(animated: true)
                    } else {
                        self?.presentErrorAlert()
                    }
                }
            }
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
