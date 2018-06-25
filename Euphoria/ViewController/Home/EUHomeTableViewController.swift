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
        if #available(iOS 11.0, *) {
            self.navigationController?.toolbar.barTintColor = UIColor(named: "navBarColor")
        } else {
            self.navigationController?.toolbar.barTintColor = UIColor(red: (243.0/255.0), green: (239.0/255.0), blue: (234.0/255.0), alpha: 1.0)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Questionnaires", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "QuestionnairesTableViewController")
        self.navigationController?.show(viewController, sender: self)
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) { }
}


