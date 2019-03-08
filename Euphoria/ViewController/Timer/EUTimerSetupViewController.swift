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
    @IBOutlet weak var okButton: UIButton!
    
    var interval: TimeInterval = 86400
    let timePicker = GSTimeIntervalPicker(frame: .zero)
    
    var selectedTimeInterval: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        
        self.view.addSubview(self.timePicker)
        NSLayoutConstraint.activate([
            self.timePicker.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 10),
            self.timePicker.bottomAnchor.constraint(equalTo: self.okButton.topAnchor, constant: 10),
            self.timePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.timePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            ])
        self.timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.timePicker.maxTimeInterval = self.interval
        self.timePicker.timeInterval = 0
        self.timePicker.onTimeIntervalChanged = {(_ newTimeInterval: TimeInterval) -> Void in
            self.selectedTimeInterval = newTimeInterval
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func didTapOkButton(_ sender: Any) {
        guard let text = self.textField.text, text.count > 0,
            self.selectedTimeInterval > 0 else {
                //TODO: Show error
            return
        }

        let session = EUSession(name: text, index: self.index, time: self.selectedTimeInterval)
        self.performSegue(withIdentifier: "AddSessionView", sender: session)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUAddSessionViewController,
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
