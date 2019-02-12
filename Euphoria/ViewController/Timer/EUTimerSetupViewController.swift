//
//  EUTimerSetupViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUTimerSetupViewController: UIViewController {

    var index: Int16 = 0
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.datePicker.countDownDuration = 0
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func didTapOkButton(_ sender: Any) {
        guard let text = self.textField.text, text.count > 0,
            self.datePicker.countDownDuration > 0 else {
                //TODO: Show error
            return
        }
        
        let session = EUSession(name: text, index: self.index, time: self.datePicker.countDownDuration)
        self.performSegue(withIdentifier: "AddSessionView", sender: session)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUSessionViewController,
            let session = sender as? EUSession {
            viewController.session = session
        }
    }
}

extension EUTimerSetupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
