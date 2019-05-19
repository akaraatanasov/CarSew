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
    var colors = [Color]()
    var employees = [Employee]()
    
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
        // TODO: - Request from backend all item types, colors and employees (GET)
        
        itemTypes.append(.seat)
        itemTypes.append(.backrest)
        itemTypes.append(.wheel)
        itemTypes.append(.doorhandle)
        itemTypes.append(.other)
        
        colors.append(.black)
        colors.append(.white)
        colors.append(.red)
        colors.append(.green)
        colors.append(.blue)
        colors.append(.yellow)
        colors.append(.brown)
        colors.append(.purple)
        colors.append(.pink)
        
        employees.append(Employee(name: "Ruler", experience: .expert, salary: 19.48))
        employees.append(Employee(name: "Greeny", experience: .junior, salary: 9.53))
        employees.append(Employee(name: "Sammy", experience: .junior, salary: 12.86))
        employees.append(Employee(name: "Peter", experience: .expert, salary: 25.53))
        employees.append(Employee(name: "Simona", experience: .junior, salary: 14.53))
    }
    
    private func getItemFromInput() -> Item? {
        guard let name = nameTextField.text else { return nil }
        guard let typeName = typeTextField.text else { return nil }
        guard let colorName = colorTextField.text else { return nil }
        guard let employeeName = employeeTextField.text else { return nil }
        guard let priceString = priceTextField.text else { return nil }
        
        let type = itemTypes.first { $0.name == typeName }
        let color = colors.first { $0.name == colorName }
        let employee = employees.first { $0.name == employeeName }
        let price = Double(priceString)
        
        if let type = type, let color = color, let employee = employee, let price = price {
            return Item(name: name, type: type, color: color, employee: employee, price: price.rounded(toPlaces: 2))
        } else {
            return nil
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let itemToSend = getItemFromInput()
        print(itemToSend ?? "nil")
        // TODO: - Send request to backend with the newly created item (POST)
        // send item
        // dismiss and reload
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
        if typeTextField.isFirstResponder { return itemTypes[row].name }
        if colorTextField.isFirstResponder { return colors[row].name }
        if employeeTextField.isFirstResponder { return employees[row].name }
        
        return nil
    }
}

// MARK: - Picker View Delegate

extension AddItemViewController: UIPickerViewDelegate {
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typeTextField.isFirstResponder { return typeTextField.text = itemTypes[row].name }
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
