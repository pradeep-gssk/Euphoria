//
//  EUHomeTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUHomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    @IBAction func didTapSettings(_ sender: Any) {
        
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        self.navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.getViewController(atIndexPath: indexPath) else { return }
        self.navigationController?.show(viewController, sender: self)
    }
    
    private func getViewController(atIndexPath indexPath: IndexPath) -> UIViewController? {
        switch HomeType(rawValue: indexPath.row) {
        case .questionnaires?:
            return UIViewController.getQuestionnaireViewController()
        case .diet?:
            return UIViewController.getDietViewController()
        case .exercises?:
            return UIViewController.getExercisesViewController()
        case .none:
            return nil
        }
    }
}
