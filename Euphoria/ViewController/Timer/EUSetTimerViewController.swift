//
//  EUSetTimerViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/22/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUSetTimerViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isToolbarHidden = true
        
        self.datePicker.countDownDuration = 0
        
        self.closeButton.rx.tap.bind(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
        
        self.okButton.rx.tap.bind(onNext: {
            
            guard let text = self.textField.text, text.count > 0, self.datePicker.countDownDuration > 0 else {
                return
            }
            
            let session = EUSession(session: text, countDownDuration: self.datePicker.countDownDuration)
            appDelegate.sessions.append(element: session)
        }).disposed(by: self.disposeBag)
    }
}


extension EUSetTimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
