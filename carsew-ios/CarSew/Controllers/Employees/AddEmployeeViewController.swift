//
//  AddEmployeeViewController.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 17.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

protocol AddEmployeeDelegate {
    func didCreateEmployee()
}

class AddEmployeeViewController: UIViewController {
    
    var delegate: AddEmployeeDelegate?
    
    // MARK: - Vars
    
    var experienceTypes = [ExperienceType]()
    
    var indicatorView: LoadingIndicator!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    
    weak var pickerView: UIPickerView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getAllЕxperienceTypes()
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        indicatorView = LoadingIndicator(frame: view.frame)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        experienceTextField.inputView = pickerView
        
        experienceTextField.delegate = self
        
        self.pickerView = pickerView
    }
    
    private func getAllЕxperienceTypes() {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.loadEmployeeProperties { [weak self] experienceTypes, error in
            if let experienceTypes = experienceTypes {
                self?.experienceTypes = experienceTypes
                self?.indicatorView.hide()
                self?.pickerView?.reloadAllComponents()
            } else if let error = error, let strongSelf = self {
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    private func create(employee employeeToCreate: EmployeeCreate) {
        indicatorView.show(from: view)
        NetworkManager.sharedInstance.create(object: employeeToCreate) { [weak self] success in
            if success {
                self?.indicatorView.hide()
                self?.delegate?.didCreateEmployee()
                self?.dismiss(animated: true)
            } else if let strongSelf = self {
                strongSelf.indicatorView.hide()
                AlertPresenter.sharedInstance.showAlert(from: strongSelf, withTitle: "Error",
                                                        andMessage: "The employee you tried to add has some incorect info. Please check your inputs!")
            }
        }
    }
    
    private func getEmployeeFromInput() -> EmployeeCreate? {
        guard let name = nameTextField.text else { return nil }
        guard let experienceName = experienceTextField.text else { return nil }
        guard let salaryString = salaryTextField.text else { return nil }
        
        let experience = experienceTypes.first { $0.title == experienceName }
        let optionalSalary = Double(salaryString)
        
        guard let experienceId = experience?.id, let salary = optionalSalary else { return nil }
        return EmployeeCreate(name: name, salary: salary, experienceId: experienceId)
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let employeeToCreate = getEmployeeFromInput() {
            create(employee: employeeToCreate)
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
