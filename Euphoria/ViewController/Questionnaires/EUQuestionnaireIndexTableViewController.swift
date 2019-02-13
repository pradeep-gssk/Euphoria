//
//  EUQuestionnaireIndexTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUQuestionnaireIndexTableViewController: UITableViewController {

    @IBOutlet weak var titleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.titleImageView.image = UIImage(named: "titleBlue")?.stretch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
    }

    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionnaire = CoreDataHelper.shared.fetchQuestionnaire(forIndex: (Int16(indexPath.row.advanced(by: 1))))
        self.performSegue(withIdentifier: "QuestionnaireView", sender: questionnaire)
    }
}
