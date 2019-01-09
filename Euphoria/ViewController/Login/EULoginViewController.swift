//
//  EULoginViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EULoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
        
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
    
    //TODO: show errors
    @IBAction func didTapSignInButton(_ sender: Any) {
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        self.showLoadingScreen()
        let router = Router(endpoint: .Login(email: email, password: password))
        APIManager.shared.requestJSON(router: router, success: { (response) in
            self.hideLoadingScreen()
            print(response)
        }, failure: { (error) in
            self.hideLoadingScreen()
            print(error)
        })
    }
    
    @IBAction func didTapFacebookButton(_ sender: Any) {
        self.loginWithFacebook()
    }
    
    func loginWithFacebook() {
        self.showLoadingScreen()
        FacebookHelper.sharedInstance.logInToFacebook(viewController: self, successWithUserExist: { (user) in
            self.hideLoadingScreen()
        }, successWithUserDoesNotExist: { (user) in
            self.hideLoadingScreen()
        }, cancelled: {
            self.hideLoadingScreen()
            self.showAlertWithMessage("FB_Cancel_Error".localized)
        }, failure:  { (error : Error?) in
            self.hideLoadingScreen()
            self.showAlertWithMessage((error?.localizedDescription)!)
        })
    }
}
