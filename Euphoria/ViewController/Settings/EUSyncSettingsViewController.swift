//
//  EUSyncSettingsViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUSyncSettingsViewController: UIViewController {
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        
        self.navigationController?.isToolbarHidden = true
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
