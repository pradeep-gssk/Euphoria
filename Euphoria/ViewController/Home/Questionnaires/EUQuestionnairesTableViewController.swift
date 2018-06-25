//
//  EUQuestionnairesTableViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/24/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUQuestionnairesTableViewController: UITableViewController {

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var homeButton: UIButton!

    private let disposeBag = DisposeBag()
    let questionnaires: [EUQuestionnaire] = [EUQuestionnaire(title: "Q1", detail: "Questionnaire 1"), EUQuestionnaire(title: "Q2", detail: "Questionnaire 2"), EUQuestionnaire(title: "Q3", detail: "Questionnaire 3"), EUQuestionnaire(title: "Q4", detail: "Questionnaire 4"), EUQuestionnaire(title: "Q5", detail: "Questionnaire 5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stretchBlueImage(self.titleImageView)
        if #available(iOS 11.0, *) {
            self.navigationController?.toolbar.barTintColor = UIColor(named: "toolBarColor")
        } else {
            self.navigationController?.toolbar.barTintColor = UIColor(red: (250.0/255.0), green: (250.0/255.0), blue: (250.0/255.0), alpha: 0.9)
        }
        self.tableView.tableFooterView = UIView()
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUQuestionnaireViewController, let questionnaire = sender as? EUQuestionnaire {
            viewController.questionnaire = questionnaire
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionnaires.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionnairesCell", for: indexPath) as! EUQuestionnairesTableViewCell
        let questionnaire = self.questionnaires[indexPath.row]
        cell.titleLabel.text = questionnaire.title
        cell.detailLabel.text = questionnaire.detail

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionnaire = self.questionnaires[indexPath.row]
        self.performSegue(withIdentifier: "ShowQuestionnaireView", sender: questionnaire)
    }
}

class EUQuestionnairesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}
