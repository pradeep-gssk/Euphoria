//
//  EUExercisesIndexTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUExercisesIndexTableViewController: UITableViewController {
    
    var selectedElement: Element = .Earth
    var exercises: [String] = []
    var selectedExercise: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exercises = CoreDataHelper.shared.fetchUniqueExercises(selectedElement.rawValue)
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as EUExercisesViewController:
            viewController.exercises = sender as? [Exercises] ?? []
            viewController.selectedExercise = self.selectedExercise
        default:
            break
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! EUExercisesTableViewCell
        cell.title.text = ExerciseType(rawValue: exercises[indexPath.row])?.exerciseString
        cell.index.text = ExerciseType(rawValue: exercises[indexPath.row])?.firstCharacter
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedExercise = ExerciseType(rawValue: self.exercises[indexPath.row])?.exerciseString ?? ""
        let array = CoreDataHelper.shared.fetchExerciseforElement(self.selectedElement.rawValue, exercise: self.exercises[indexPath.row])
        self.performSegue(withIdentifier: "ShowExercisesView", sender: array)
    }
}

class EUExercisesTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var index: UILabel!
}
