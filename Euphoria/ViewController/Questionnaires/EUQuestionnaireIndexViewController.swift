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
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleImageView.image = UIImage(named: "titleBlue")?.stretch()
        self.designViews()
        self.questionnaireIndexTableView()
    }
    
    func designViews() {
        self.emailButton.backgroundColor = UIColor.color(red: 243.0, green: 239.0, blue: 234.0, alpha: 1)
        self.emailButton.layer.shadowColor = UIColor.black.cgColor
        self.emailButton.layer.shadowOpacity = 0.6
        self.emailButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.emailButton.layer.masksToBounds = true
        self.emailButton.layer.cornerRadius = 55.0/2
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapEmail(_ sender: Any) {
//        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
//            MFMailComposeViewController.canSendMail() else {
//            //TODO: show failure alert
//            return
//        }
        
        guard MFMailComposeViewController.canSendMail() else {
                //TODO: show failure alert
                return
        }
        
        let questionnaires = CoreDataHelper.shared.fetchAnsweredQuestionnaire()
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
        mail.setToRecipients([recipient])
        mail.setSubject("Questionnaires")
        mail.setMessageBody("Questions and Answers", isHTML: true)
        mail.addAttachmentData(data, mimeType: "text/plain", fileName: "Questionnaires.txt")
        self.present(mail, animated: true) {
        }
        
        
        
        //        mailComposer.addAttachmentData(data, mimeType: "text/plain", fileName: "test")
        
//        let fileURL = documentsDirectory.appendingPathComponent("Questionnaires.txt")
//        FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
//        do {
//            try joined.write(to: fileURL, atomically: true, encoding: .utf8)
//
//        }
//        catch {
//            print("error")
//        }
    }
    
    func questionnaireIndexTableView() {
        guard let viewController = self.children.first as? EUQuestionnaireIndexTableViewController else { return }
        viewController.didSelectRowAt = { (indexPath) -> Void in
            let questionnaire = CoreDataHelper.shared.fetchQuestionnaire(forIndex: (Int16(indexPath.row.advanced(by: 1))))
            self.performSegue(withIdentifier: "QuestionnaireView", sender: questionnaire)
        }
        
        viewController.hideEmailButton = { (hide) -> Void in
            self.emailButton.isHidden = hide
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
        if let _ = error {
            self.showAlertWithMessage("Error sending email")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
