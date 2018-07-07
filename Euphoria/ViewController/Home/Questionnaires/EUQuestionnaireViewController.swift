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
    
    private let disposeBag = DisposeBag()
    private var currentIndex = 0
    
    var questionnaire: EUQuestionnaire = EUQuestionnaire()
    
    let options: [String] = ["Relaxation", "Movement", "Healing", "Detox", "Food and nature", "Beauty/pampering", "Recovery", "Weight loss"]
    var selectedOption: [Int: String] = [:]

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
        
        let overlayIndicator = UIView(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: 35))
        overlayIndicator.backgroundColor = UIColor.red
        overlayIndicator.alpha = 0.5
    }
    
    func showCurrentQuestionnaire() {
        
    }
}

extension EUQuestionnaireViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.options.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let option = self.options[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! EUQuestionnairesViewTableViewCell
            
            cell.accessoryType = (self.selectedOption[indexPath.row] != nil) ? .checkmark : .none
            cell.titleLabel.text = option
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherCell", for: indexPath) as! EUQuestionnairesViewTableViewCell
        return cell
    }
}

extension EUQuestionnaireViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.selectedOption[indexPath.row] != nil) {
            self.selectedOption.removeValue(forKey: indexPath.row)
        }
        else {
            self.selectedOption[indexPath.row] = ""
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

class EUQuestionnairesViewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var otherTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let textField = self.otherTextField {
            textField.setPaddingPointsOnLeft(14, andRight: 14)
        }
    }
}
