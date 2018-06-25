//
//  EUQuestionnaireViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/24/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUQuestionnaireViewController: UIViewController {

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var mainStackView: UIStackView!
    
    private let disposeBag = DisposeBag()
    private var currentIndex = 0
    
    var questionnaire: EUQuestionnaire = EUQuestionnaire()
    
    let options: [String] = ["Relaxation", "Movement", "Healing", "Detox", "Food and nature", "Beauty/pampering", "Recovery", "Weight loss"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stretchBlueImage(self.titleImageView)
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
        
        self.titleLabel.text = self.questionnaire.detail
        self.otherTextField.setPaddingPointsOnLeft(14, andRight: 14)
        
        self.mainStackView.spacing = (UIScreen.main.bounds.height > 480) ? 10 : 0
        
        let overlayIndicator = UIView(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: 35))
        overlayIndicator.backgroundColor = UIColor.red
        overlayIndicator.alpha = 0.5
        self.pickerView.addSubview(overlayIndicator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self.pickerView)
    }
    
    func showCurrentQuestionnaire() {
        
    }
}

extension EUQuestionnaireViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.options.count
    }
}

extension EUQuestionnaireViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let option = self.options[row]
        return NSAttributedString(string: option, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "GillSans", size: 24) ?? UIFont.systemFont(ofSize: 24)])
    }
}

