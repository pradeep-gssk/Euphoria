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

    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        self.navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let homeType = HomeType(rawValue: indexPath.row) else { return }
        let viewController = UIViewController.getViewController(name: homeType.storyboard, identifier: homeType.identifier)
        self.navigationController?.show(viewController, sender: self)
    }
}
