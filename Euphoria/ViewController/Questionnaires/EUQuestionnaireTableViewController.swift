//
//  EUQuestionnaireTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/4/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUQuestionnaireTableViewController: UITableViewController {

    var questionObject: Questionnaire!
    var options: [Option] = []
    var numberOfSections = 2
    var checkIfAllAnswered: (() -> Void)?
    var clearTextField: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setNumberOfSections() {
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.options.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            return
        }
        
        let answer = self.options[indexPath.row].option
        CoreDataHelper.shared.updateAnswer(self.questionObject, string: answer)

        if let optionType = OptionType(rawValue: Int(self.questionObject.optionType)) {
            switch optionType {
            case .toggle:
                switch answer?.boolValue {
                case true:
                    numberOfSections = 2
                default:
                    numberOfSections = 1
                    self.clearDetails()
                }
            case .always:
                self.clearDetails()
            case .never:
                break
            }
        }
        tableView.reloadData()
        self.checkIfAllAnswered?()
    }
    
    func clearDetails() {
        CoreDataHelper.shared.updateDetails(questionObject, details: nil)
        clearTextField = true
    }
}

extension EUQuestionnaireTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearTextField = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.trimmingCharacters(in: .whitespaces).count > 0,
            clearTextField == false else {
            textField.text = nil
            self.clearDetails()
            return
        }
        
        CoreDataHelper.shared.updateDetails(questionObject, details: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text, text.trimmingCharacters(in: .whitespaces).count > 0,
            let optionType = OptionType(rawValue: Int(self.questionObject.optionType)),
            optionType == .always else {
            return true
        }
        
        CoreDataHelper.shared.updateAnswer(self.questionObject, string: nil)
        CoreDataHelper.shared.updateDetails(questionObject, details: text)
        self.tableView.reloadData()
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
