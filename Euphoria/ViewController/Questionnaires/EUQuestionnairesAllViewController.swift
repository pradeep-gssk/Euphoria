//
//  EUQuestionnairesAllViewController.swift
//  Euphoria
//
//  Created by Pradeep Guduru on 4/19/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

//private class QuestionnaireOject {
//
//}

class QuestionnaireOject: NSObject {
    var title: String = ""
    var questions: [Questionnaire] = []
}

class EUQuestionnairesAllViewController: UITableViewController {
    
    var allQuestionnaires: [QuestionnaireOject] = []
    @IBOutlet weak var titleImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImageView.image = UIImage(named: "titleBlue")?.stretch()
        self.tableView.tableFooterView = UIView()
        self.loadQuestionnaires()
    }
    
    func loadQuestionnaires() {
        guard let customerId = EUUser.user?.customerId else {
                //TODO: show failure alert
                return
        }
        
        let questionnaires = CoreDataHelper.shared.fetchAnsweredQuestionnaire(Int64(customerId))
        var currentTitle: String = ""
        var questionnaireObject = QuestionnaireOject()
        var currentIndex = 0

        for question in questionnaires {
            if let title = question.questionnaires?.title,
                currentTitle != title {
                questionnaireObject = QuestionnaireOject()
                currentTitle = title
                questionnaireObject.title = title
                currentIndex += 1
                self.allQuestionnaires.append(questionnaireObject)
            }
            questionnaireObject.questions.append(question)
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.allQuestionnaires.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allQuestionnaires[section].questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! EUQuestionnairesAllCell
        let question = self.allQuestionnaires[indexPath.section].questions[indexPath.row]
        
        cell.questionLabel.text = question.question
        cell.answerLabel.text = question.answer
        cell.detailLabel.text = question.details

        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "    " + self.allQuestionnaires[section].title
    }

}


class EUQuestionnairesAllCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}
