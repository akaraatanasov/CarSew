//
//  AddEmployeeViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {
    
    // MARK: - Vars
    
    var experienceTypes = [EmployeeExperience]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    
    weak var pickerView: UIPickerView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getAllЕxperienceTypes()
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        experienceTextField.inputView = pickerView
        
        experienceTextField.delegate = self
        
        self.pickerView = pickerView
    }
    
    private func getAllЕxperienceTypes() {
        // TODO: - Request from backend all employee experience types (GET)
        
        experienceTypes.append(.junior)
        experienceTypes.append(.expert)
    }
    
    private func getEmployeeFromInput() -> Employee? {
        guard let name = nameTextField.text else { return nil }
        guard let experienceName = experienceTextField.text else { return nil }
        guard let salaryString = salaryTextField.text else { return nil }
        
        let experience = experienceTypes.first { $0.name == experienceName }
        let salary = Double(salaryString)
        
        if let experience = experience, let salary = salary {
            return Employee(name: name, experience: experience, salary: salary.rounded(toPlaces: 2))
        } else {
            return nil
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let employeeToSend = getEmployeeFromInput()
        print(employeeToSend ?? "nil")
        // TODO: - Send request to backend with the newly created employee (POST)
        // send employee
        // dismiss and reload
    }
    
}

// MARK: - Picker View Data Source

extension AddEmployeeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if experienceTextField.isFirstResponder { return experienceTypes.count }
        
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if experienceTextField.isFirstResponder { return experienceTypes[row].name }
        
        return nil
    }
}

// MARK: - Picker View Delegate

extension AddEmployeeViewController: UIPickerViewDelegate {
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if experienceTextField.isFirstResponder { return experienceTextField.text = experienceTypes[row].name }
    }
}

// MARK: - Text Field Delegate

extension AddEmployeeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}
