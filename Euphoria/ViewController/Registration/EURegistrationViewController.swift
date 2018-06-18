//
//  EURegistrationViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/10/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EURegistrationViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class EURegistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let disposeBag = DisposeBag()
    
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
        
        self.datePicker.rx.value.subscribe({[weak self] date in
            print(date.element)
        }).disposed(by: self.disposeBag)
        
        self.checkBox.rx.tap.subscribe({[weak self] date in
            guard let strongSelf = self else { return }
            let viewController = EUConcentViewController.loadPrivacyView()
            strongSelf.navigationController?.show(viewController, sender: self)
        }).disposed(by: self.disposeBag)
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
