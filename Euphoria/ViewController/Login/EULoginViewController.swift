//
//  EULoginViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EULoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    func removeConcentViewIfExist() {
        guard let navigationController = self.navigationController, navigationController.viewControllers.first is EUConcentViewController else {
            return
        }
        
        var viewControllers = navigationController.viewControllers
        viewControllers.removeFirst()
        navigationController.viewControllers = viewControllers
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.removeConcentViewIfExist()
        self.emailTextField.desginView()
        self.passwordTextField.desginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //TODO: show errors
    @IBAction func didTapSignInButton(_ sender: Any) {
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        UserDefaults.standard.set(true, forKey: USER_PROFILE_DATA)
        self.showHomeView()
//        self.showLoadingScreen()
//        let router = Router(endpoint: .Login(email: email, password: password))
//        APIManager.shared.requestJSON(router: router, success: { (response) in
//            self.hideLoadingScreen()
//            appDelegate.showHomeView()
//        }, failure: { (error) in
//            self.hideLoadingScreen()
//            print(error)
//        })
    }
    
    func showHomeView() {
        UIView.animate(withDuration: 0.1) {
            appDelegate.showHomeView()
        }
    }
    
    @IBAction func didTapGesture(_ sender: Any) {
        let viewController = EUConcentViewController.loadPrivacyView()
        self.navigationController?.show(viewController, sender: self)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        self.view.frame.origin.y = -100
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
