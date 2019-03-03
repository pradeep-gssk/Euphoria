//
//  EUDietIndexViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/3/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUDietIndexViewController: UIViewController {
    
    var diets: [Diet] = []
    var selectedDiet: String = ""

    var dietsDictionary = [String: [Diet]]()
    var dietSectionTitles = [String]()
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dietsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = self.selectedDiet
        self.indexDiets()
        self.dietsTableView.tableFooterView = UIView()
    }
    
    func indexDiets() {
        for diet in diets {
            let key = String(diet.name?.prefix(1) ?? "#")
            if var dietValues = dietsDictionary[key] {
                dietValues.append(diet)
                dietsDictionary[key] = dietValues
            }
            else {
                dietsDictionary[key] = [diet]
            }
        }
        
        dietSectionTitles = [String](dietsDictionary.keys)
        dietSectionTitles = dietSectionTitles.sorted(by: { $0 < $1 })
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as EUDietViewController:
            viewController.diet = sender as? Diet
        default:
            break
        }
    }
}

extension EUDietIndexViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dietSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = dietSectionTitles[section]
        if let dietValues = dietsDictionary[key] {
            return dietValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndexCell", for: indexPath) as! EUIndexListViewCell
        let key = dietSectionTitles[indexPath.section]
        let diet = dietsDictionary[key]?[indexPath.row]
        cell.titleLabel.text = diet?.name
        return cell

    }
}

extension EUDietIndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.dietSectionTitles
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexItem = self.dietSectionTitles[section]
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 40))
        view.backgroundColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1.0)
        let label = UILabel(frame: CGRect(x: 30, y: 0, width: UIScreen.main.bounds.width - 110, height: 40))
        label.font = UIFont(name: "GillSans-SemiBold", size: 18)
        label.textColor = UIColor.white
        label.text = indexItem
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = dietSectionTitles[indexPath.section]
        let diet = dietsDictionary[key]?[indexPath.row]
        self.performSegue(withIdentifier: "ShowDietView", sender: diet)
    }
}
