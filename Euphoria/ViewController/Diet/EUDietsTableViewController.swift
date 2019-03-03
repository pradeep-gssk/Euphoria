//
//  EUDietsTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/2/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUDietsTableViewController: UITableViewController {
    var selectedTaoist: Taoist = .Earth
    var diets: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diets = CoreDataHelper.shared.fetchUniqueDiets(self.selectedTaoist.rawValue)

        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        let diets = CoreDataHelper.shared.fetchDietforTaoist(self.selectedTaoist.rawValue, diet: self.diets[indexPath.row])
        print(diets)
    }
}

class EUDietsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var index: UILabel!
}
