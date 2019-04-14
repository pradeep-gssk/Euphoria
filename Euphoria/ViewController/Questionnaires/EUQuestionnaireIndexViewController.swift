//
//  EUQuestionnaireIndexViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/3/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import MessageUI

class EUQuestionnaireIndexViewController: UIViewController {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var floatingButton: EUButton!
    var questionnaireTableView: EUQuestionnaireIndexTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleImageView.image = UIImage(named: "titleBlue")?.stretch()
        self.loadFloatingButton()
        self.questionnaireIndexTableView()
    }
    
    func loadFloatingButton() {
        
        self.floatingButton.add(color: UIColor.color(red: 243.0, green: 239.0, blue: 234.0, alpha: 1), title: "Email", image: UIImage(named: "envelopeBlue")) { (_) in
            self.didTapEmail()
        }
        
        self.floatingButton.add(color: UIColor.color(red: 243.0, green: 239.0, blue: 234.0, alpha: 1), title: "Refresh", image: UIImage(named: "refresh")) { (_) in
            self.clearAllAnswers()
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clearAllAnswers() {
        guard let customerId = EUUser.user?.customerId else { return }
        CoreDataHelper.shared.clearAllAnswers(Int64(customerId))
//        questionnaireTableView?.designViews()
    }
    
    func didTapEmail() {
        guard MFMailComposeViewController.canSendMail(),
            let customerId = EUUser.user?.customerId else {
                //TODO: show failure alert
                return
        }

        let questionnaires = CoreDataHelper.shared.fetchAnsweredQuestionnaire(Int64(customerId))
        var array: [String] = []
        var currentTitle: String = ""
        var currentIndex = 0

        for question in questionnaires {
            if let title = question.questionnaires?.title,
                currentTitle != title {
                currentTitle = title
                array.append(currentIndex > 0 ? "\n\n\(title)" : title)
                currentIndex += 1
            }

            let index = question.index + 1
            if let value = question.question {
                array.append("\n\(index). \(value)")
            }
            if let value = question.answer {
                array.append("Answer: \(value)")
            }
            if let value = question.details {
                array.append("Details: \(value)")
            }
        }

        let joined = array.joined(separator: "\n")

        guard let data = joined.data(using: .utf8) else { return }

        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([recipient])
        mail.setSubject("Questionnaires")
        mail.setMessageBody("Questions and Answers", isHTML: true)
        mail.addAttachmentData(data, mimeType: "text/plain", fileName: "Questionnaires.txt")
        self.present(mail, animated: true) {
        }
    }
    
    func questionnaireIndexTableView() {
        guard let viewController = self.children.first as? EUQuestionnaireIndexTableViewController,
            let customerId = EUUser.user?.customerId else { return }
        questionnaireTableView = viewController
        questionnaireTableView?.didSelectRowAt = { (indexPath) -> Void in
            let questionnaire = CoreDataHelper.shared.fetchQuestionnaire(forIndex: (Int16(indexPath.row.advanced(by: 1))), Int64(customerId))
            self.performSegue(withIdentifier: "QuestionnaireView", sender: questionnaire)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUQuestionnaireViewController,
            let questionnaires = sender as? Questionnaires {
            CoreDataHelper.shared.updateState(questionnaires, state: 0)
            var questions = questionnaires.questionnaire?.allObjects as? [Questionnaire] ?? []
            questions.sort { (question1, question2) -> Bool in
                return question1.index < question2.index
            }
            viewController.questions = questions
            viewController.questionnaires = questionnaires
        }
    }
}

extension EUQuestionnaireIndexViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if let _ = error {
                self.showAlertWithMessage("Error sending email")
            }
            else if result == .sent {
                self.showAlertWithMessage("Your message has been sent")
            }
        }
    }
}
