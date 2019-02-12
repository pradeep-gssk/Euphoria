//
//  EUExercisesIndexTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUExercisesIndexTableViewController: UITableViewController {

    var exercises: [Exercises] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.exercises = CoreData.sharedInstance.fetchExercises()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUExercisesViewController {
            viewController.exercise = sender as? Exercises
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        self.performSegue(withIdentifier: "ShowExercisesView", sender: exercises[indexPath.row])
    }
}
