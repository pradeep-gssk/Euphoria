//
//  EUHomeTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUHomeTableViewController: UITableViewController {
    
    var questionnaire1Answered = false
    var selectedElement: Element = .Earth

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.questionnaire1Answered = CoreDataHelper.shared.checkIfAllAnswered(forIndex: 1)
        self.tableView.reloadData()
        self.selectedElement = self.findElement()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as EUDietsTableViewController:
            viewController.selectedElement = self.selectedElement
        default:
            break
        }
    }

    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        self.navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Table view datasource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        switch indexPath.row {
        case 1, 2:
            cell.isUserInteractionEnabled = self.questionnaire1Answered
            cell.contentView.alpha = self.questionnaire1Answered ? 1 : 0.5
            cell.contentView.backgroundColor = self.questionnaire1Answered ?
                UIColor.white :
                UIColor.color(red: 199, green: 200, blue: 202, alpha: 0.5)
        default:
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let homeType = HomeType(rawValue: indexPath.row) else { return }
        let viewController = UIViewController.getViewController(name: homeType.storyboard, identifier: homeType.identifier)
        self.navigationController?.show(viewController, sender: self)
    }
}
