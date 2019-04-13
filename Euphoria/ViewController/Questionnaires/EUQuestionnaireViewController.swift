//
//  EUQuestionnaireViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUQuestionnaireViewController: UIViewController {
    
    var questionnaires: Questionnaires!
    var questions: [Questionnaire] = []
    var questionObject: Questionnaire!
    var questionnaireTableView: EUQuestionnaireTableViewController?
    var selectedElement: Element?
    var allQuestionsAnswered: Bool = false
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor.color(red: 243.0, green: 239.0, blue: 234.0, alpha: 1)
        self.titleLabel.text = self.questionnaires.title
        self.titleImageView.image = UIImage(named: "titleBlue")?.stretch()
        self.questionnaireTableView = self.children.first as? EUQuestionnaireTableViewController
        self.initializeValues()
        self.questionnaireTableView?.checkIfAllAnswered = {
            self.checkIfAllAnswered()
        }
        self.loadQuestionnaire()
    }
    
    func initializeValues() {
        guard let customerId = EUUser.user?.customerId else { return }
        if questionnaires.index == 1, CoreDataHelper.shared.checkIfAllAnswered(forIndex: self.questionnaires.index, Int64(customerId)) {
            selectedElement = findElement(Int64(customerId))
        }
        else if questionnaires.index != 1 {
            allQuestionsAnswered = CoreDataHelper.shared.checkIfAllAnswered(forIndex: self.questionnaires.index, Int64(customerId))
        }
    }
    
    func getColor(_ colorIndex: Int16) -> UIColor {
        switch colorIndex {
        case 1:
            return UIColor.red
        case 2:
            return UIColor.yellow
        case 3:
            return UIColor.white
        case 4:
            return UIColor.black
        default:
            return UIColor.green
        }
    }
    
    func loadQuestionnaire() {
        self.questionObject = questions[Int(questionnaires.state)]
        
        if self.questionnaires.index == 1 {
            let attributes: [NSAttributedString.Key : Any] =
                [.foregroundColor: getColor(questionObject.colorIndex),
                 .font: UIFont.boldSystemFont(ofSize: 30)]
            let dotText = NSMutableAttributedString(string: "• ", attributes: attributes as [NSAttributedString.Key : Any])
            let text = NSMutableAttributedString(string: (questionObject.question ?? ""), attributes: [.foregroundColor: UIColor.white])
            dotText.append(text)
            self.questionLabel.attributedText = dotText
        }
        else {
            self.questionLabel.text = questionObject.question
        }
        
        self.questionnaireTableView?.questionObject = self.questionObject
        self.questionnaireTableView?.options = questionObject.options?.allObjects as? [Option] ?? []
        self.questionnaireTableView?.setNumberOfSections()
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
            self.questionnaireTableView?.tableView.reloadData()
        }
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        if let value = self.questionObject.answer?.boolValue, value == false {
            CoreDataHelper.shared.updateDetails(questionObject, details: nil)
        }

        let state = questionnaires.state + 1
        CoreDataHelper.shared.updateState(self.questionnaires, state: state)
        self.loadQuestionnaire()
        self.questionnaireTableView?.tableView.reloadData()
    }
    
    func checkIfAllAnswered() {
        guard let customerId = EUUser.user?.customerId else { return }
        if CoreDataHelper.shared.checkIfAllAnswered(forIndex: self.questionnaires.index, Int64(customerId)) {
            switch self.questionnaires.index {
            case 1:
                self.showElementAlert()
            default:
                if allQuestionsAnswered == false {
                    self.showAlertWithMessage("Thank you for completing Questionnaire \(self.questionnaires.index)")
                }
            }
        }
    }
    
    func showElementAlert() {
        guard let customerId = EUUser.user?.customerId else { return }
        let currentElement = self.findElement(Int64(customerId))
        switch selectedElement {
        case .none:
            break
        case .some(let element):
            guard element != currentElement else {
                return
            }
        }
        
        selectedElement = currentElement
        self.showNoAlertWithMessage("It seems that at this moment you have issues with \(currentElement.rawValue) element. Please check Diet and Exercises")
    }
}
