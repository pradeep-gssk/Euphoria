//
//  EUDietsTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/2/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUDietsTableViewController: UITableViewController {
    var selectedElement: Element = .Earth
    var diets: [String] = []
    var selectedDiet: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diets = CoreDataHelper.shared.fetchUniqueDiets(self.selectedElement.rawValue)
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as EUDietIndexViewController:
            viewController.diets = sender as? [Diet] ?? []
            viewController.selectedDiet = self.selectedDiet
        default:
            break
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.diets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DietsCell", for: indexPath) as! EUDietsTableViewCell
        cell.title.text = DietType(rawValue: diets[indexPath.row])?.dietString
        cell.index.text = DietType(rawValue: diets[indexPath.row])?.firstCharacter
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDiet = DietType(rawValue: self.diets[indexPath.row])?.dietString ?? ""
        let diets = CoreDataHelper.shared.fetchDietforElement(self.selectedElement.rawValue, diet: self.diets[indexPath.row])
        self.performSegue(withIdentifier: "ShowDietsIndexView", sender: diets)
    }
}

class EUDietsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var index: UILabel!
}
