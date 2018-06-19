//
//  EULoginViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EULoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
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
        
        self.signInButton.rx.tap.subscribe({[weak self] state in
            guard let strongSelf = self else { return }
        }).disposed(by: self.disposeBag)

        self.facebookButton.rx.tap.subscribe({[weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.loginWithFacebook()
        }).disposed(by: self.disposeBag)
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
