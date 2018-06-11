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
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.setPaddingPoints(10)
        self.lastNameTextField.setPaddingPoints(10)
        self.dobTextField.setPaddingPoints(10)
        self.emailTextField.setPaddingPoints(10)
        self.passwordTextField.setPaddingPoints(10)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
        
        self.dobTextField.inputView = self.datePicker
        
        self.datePicker.rx.value.subscribe({[weak self] date in
            print(date.element)
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
