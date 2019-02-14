//
//  EURegistrationViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/10/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EURegistrationViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

class EURegistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextField.desginView()
        self.lastNameTextField.desginView()
        self.dobTextField.desginView(left: 14, right: 11)
        self.genderTextField.desginView(left: 13, right: 6)
        self.emailTextField.desginView()
        self.passwordTextField.desginView()
        
        self.dobTextField.inputView = self.datePicker
        self.genderTextField.inputView = self.pickerView
        
        self.datePicker.maximumDate = Date()
    }
    
    @IBAction func didChangeDatePickerValue(_ sender: Any) {
        
    }
        
    @IBAction func didTapSubmitButton(_ sender: Any) {
        self.registerUser()
    }
    
    func registerUser() {
        let language: String = Locale.current.languageCode ?? "el-GR"
        let data: [String: Any] = ["id": 0, "FolderId": 0, "Alias": "", "Name": "Sri", "Surname": "Guduru", "Email": "eenadu18@gmail.com", "DateOfBirth": "03-10-1984", "Language": language, "Gender": 1,  "Phone": "5109458010", "Password": "pradeep123", "PMSProperty": "", "PMSRoom": "", "PMSAccount": "", "PMSReservationId": "", "IsInhouse": false]
        
        let router = Router(endpoint: .Registration(data: data))

        APIManager.shared.requestJSON(router: router, success: { (response) in
            print(response)
        }, failure: { (error: Error) in
            print(error)
        })
    }
    
    @IBAction func didTapPolicyLabel(_ sender: Any) {
        let viewController = EUConcentViewController.loadPrivacyView()
        self.navigationController?.show(viewController, sender: self)
    }
}

extension EURegistrationTableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

extension EURegistrationTableViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (row == 0) ? "Male" : "Female"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let result = (row == 0) ? "Male" : "Female"
        print(result)
    }
}
