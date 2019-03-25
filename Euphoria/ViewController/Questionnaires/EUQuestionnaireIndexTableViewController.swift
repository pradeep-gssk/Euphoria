//
//  EUQuestionnaireIndexTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUQuestionnaireIndexTableViewController: UITableViewController {
    
    var cellEnabled: [Bool] = [true, false, false, false, false]
    var didSelectRowAt: ((_ indexPath: IndexPath) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.designViews()
    }
    
    func designViews() {
        for i in 1...4 {
            let value = CoreDataHelper.shared.checkIfAllAnswered(forIndex: Int16(i))
            self.cellEnabled[i] = value
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view datasource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let cellEnabled = self.cellEnabled[indexPath.row]
        cell.isUserInteractionEnabled = cellEnabled
        cell.contentView.alpha = cellEnabled ? 1 : 0.5
        cell.contentView.backgroundColor = cellEnabled ?
            UIColor.white :
            UIColor.color(red: 199, green: 200, blue: 202, alpha: 0.5)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRowAt?(indexPath)
    }
}
