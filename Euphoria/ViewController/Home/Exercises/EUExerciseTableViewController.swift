//
//  EUExerciseTableViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUExerciseTableViewController: UITableViewController {

    @IBOutlet weak var homeButton: UIButton!
    private let disposeBag = DisposeBag()

    let exercises: [EUExercise] = [EUExercise(title: "Y", detail: "Yoga"), EUExercise(title: "P", detail: "Pilates"), EUExercise(title: "R", detail: "Running"), EUExercise(title: "C", detail: "Climbing"), EUExercise(title: "Q", detail: "Qi Gong"), EUExercise(title: "S", detail: "Stretching")]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setToolBarColor()
        self.tableView.tableFooterView = UIView()
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUExerciseListViewController, let exercise = sender as? EUExercise {
            viewController.exercise = exercise
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! EUExerciseTableViewCell
        let exercise = self.exercises[indexPath.row]
        cell.titleLabel.text = exercise.title
        cell.detailLabel.text = exercise.detail
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = self.exercises[indexPath.row]
        self.performSegue(withIdentifier: "ShowExerciseList", sender: exercise)
    }
}

class EUExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}
