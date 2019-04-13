//
//  EUHomeTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUHomeViewController: UIViewController {
    var selectedElement: Element = .Earth
    
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var userButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.height == 480 {
            self.logoStackView.isHidden = true
        }
        self.homeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getSelectedElement()
        self.userButton.loadUserImage()
    }
    
    func getSelectedElement() {
        guard let customerId = EUUser.user?.customerId else { return }
        self.selectedElement = self.findElement(Int64(customerId))
    }
    
    func homeTableView() {
        guard let viewController = self.children.first as? EUHomeTableViewController else { return }
        viewController.didSelectRowAt = { (indexPath) -> Void in
            
            guard let homeType = HomeType(rawValue: indexPath.row) else { return }
            let viewController = UIViewController.getViewController(name: homeType.storyboard, identifier: homeType.identifier)
            switch viewController {
            case let vc as EUDietsTableViewController:
                vc.selectedElement = self.selectedElement
            case let vc as EUExercisesIndexTableViewController:
                vc.selectedElement = self.selectedElement
            default:
                break
            }
            self.navigationController?.show(viewController, sender: self)
        }
    }
    
    @IBAction func didTapLogo(_ sender: Any) {
        guard let url = URL(string: website) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

class EUHomeTableViewController: UITableViewController {
    
    var didSelectRowAt: ((_ indexPath: IndexPath) -> Void)?
    var questionnaire1Answered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkQuetionnaire1Answered()
        self.tableView.reloadData()
    }
    
    func checkQuetionnaire1Answered() {
        guard let customerId = EUUser.user?.customerId else { return }
        self.questionnaire1Answered = CoreDataHelper.shared.checkIfAllAnswered(forIndex: 1, Int64(customerId))
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
        self.didSelectRowAt?(indexPath)
    }
}
