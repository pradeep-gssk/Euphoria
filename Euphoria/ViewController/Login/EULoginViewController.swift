//
//  EULoginViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
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
        appDelegate.showHomeView()
    }
    
    @IBAction func didTapFacebookButton(_ sender: Any) {
        self.loginWithFacebook()
    }
    
    func loginWithFacebook() {
    }
}
