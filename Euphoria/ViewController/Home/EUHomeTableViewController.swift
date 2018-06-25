//
//  EUHomeTableViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/24/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUHomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.toolbar.barTintColor = UIColor(named: "navBarColor")
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Questionnaires", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "QuestionnairesTableViewController")
        self.navigationController?.show(viewController, sender: self)
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) { }
}


