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
    
    var experienceTypes = [ExperienceType]()
    
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
        // show loading indicator
        NetworkManager.sharedInstance.loadEmployeeCreate { [weak self] experienceTypes in
            self?.experienceTypes = experienceTypes
            DispatchQueue.main.async {
                // hide loading indicator
                self?.pickerView?.reloadAllComponents()
            }
        }
    }
    
    private func getEmployeeFromInput() -> CreateEmployeeRequest? {
        guard let name = nameTextField.text else { return nil }
        guard let experienceName = experienceTextField.text else { return nil }
        guard let salaryString = salaryTextField.text else { return nil }
        
        let experience = experienceTypes.first { $0.title == experienceName }
        let salary = Double(salaryString)
        
        if let experienceId = experience?.id, let salary = salary {
            return CreateEmployeeRequest(name: name, salary: salary, experienceId: experienceId)
        } else {
            return nil
        }
    }
    
    private func presentErrorAlert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "The employee you tried to add has some incorect info. Please check your inputs!",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let employeeToSend = getEmployeeFromInput() {
            NetworkManager.sharedInstance.create(employee: employeeToSend) { [weak self] success in
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

extension AddEmployeeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if experienceTextField.isFirstResponder { return experienceTypes.count }
        
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if experienceTextField.isFirstResponder { return experienceTypes[row].title }
        
        return nil
    }
}

// MARK: - Picker View Delegate

extension AddEmployeeViewController: UIPickerViewDelegate {
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if experienceTextField.isFirstResponder { return experienceTextField.text = experienceTypes[row].title }
    }
}

// MARK: - Text Field Delegate

extension AddEmployeeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}
