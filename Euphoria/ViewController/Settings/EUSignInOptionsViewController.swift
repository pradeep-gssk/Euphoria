//
//  EUSignInOptionsViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUSignInOptionsViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var retypeNewEmailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var retypePasswordField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.newEmailField.desginView()
        self.retypeNewEmailField.desginView()
        self.passwordField.desginView()
        self.retypePasswordField.desginView()
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
}
