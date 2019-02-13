//
//  EUQuestionnaireViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUQuestionnaireViewController: UIViewController {
    
    var questionnaires: Questionnaires = Questionnaires()
    var questions: [Questionnaire] = []
    var questionObject: Questionnaire = Questionnaire()
    var options: [Option] = []
    var numberOfSections = 2
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor.color(red: 243.0, green: 239.0, blue: 234.0, alpha: 1)

        self.titleLabel.text = self.questionnaires.title
        self.titleImageView.image = UIImage(named: "titleBlue")?.stretch()
        self.loadQuestionnaire()
    }
    
    func loadQuestionnaire() {
        self.questionObject = questions[Int(questionnaires.state)]
        self.questionLabel.text = questionObject.question
        self.options = questionObject.options?.allObjects as? [Option] ?? []
        self.options.sort { (option1, option2) -> Bool in
            return option1.index < option2.index
        }
        
        if let optionType = OptionType(rawValue: Int(self.questionObject.optionType)) {
            switch optionType {
            case .never:
                numberOfSections = 1
            case .toggle:
                numberOfSections = (self.questionObject.answer?.boolValue ?? false) ? 2 : 1
            case .always:
                numberOfSections = 2
            }
        }
        
        self.previousButton.isEnabled = (self.questionnaires.state <= 0) ? false : true
        self.nextButton.isEnabled = (self.questionnaires.state >= (self.questionnaires.total - 1)) ? false : true
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        let state = questionnaires.state - 1
        if state >= 0 {
            CoreDataHelper.shared.updateState(self.questionnaires, state: state)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapPrevious(_ sender: Any) {
        let state = questionnaires.state - 1
        if state >= 0 {
            CoreDataHelper.shared.updateState(self.questionnaires, state: state)
            self.loadQuestionnaire()
            self.optionsTableView.reloadData()
        }
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        if let value = self.questionObject.answer?.boolValue, value == false {
            CoreDataHelper.shared.updateDetails(questionObject, details: nil)
        }

        let state = questionnaires.state + 1
        CoreDataHelper.shared.updateState(self.questionnaires, state: state)
        self.loadQuestionnaire()
        self.optionsTableView.reloadData()
    }
}

extension EUQuestionnaireViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
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
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherCell", for: indexPath) as! EUQuestionnairesViewTableViewCell
            
            if let optionType = OptionType(rawValue: Int(self.questionObject.optionType)) {
                switch optionType {
                case .toggle:
                    cell.otherTextField?.placeholder = "Please specify "
                case .always, .never:
                    cell.otherTextField?.placeholder = "Other"
                }
            }
            
            cell.otherTextField?.text = self.questionObject.details
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! EUQuestionnairesViewTableViewCell
        let option = options[indexPath.row]
        cell.titleLabel.text = option.option
        cell.accessoryType = (questionObject.answer == option.option) ? .checkmark : .none
        return cell
    }
}

extension EUQuestionnaireViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answer = self.options[indexPath.row].option
        CoreDataHelper.shared.updateAnswer(self.questionObject, string: answer)
        
        if let optionType = OptionType(rawValue: Int(self.questionObject.optionType)) {
            switch optionType {
            case .toggle:
                numberOfSections = (answer?.boolValue ?? false) ? 2 : 1
            default:
                break
            }
        }
        
        tableView.reloadData()
    }
}

extension EUQuestionnaireViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.trimmingCharacters(in: .whitespaces).count > 0 else {
            CoreDataHelper.shared.updateDetails(questionObject, details: nil)
            return
        }
        CoreDataHelper.shared.updateDetails(questionObject, details: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
