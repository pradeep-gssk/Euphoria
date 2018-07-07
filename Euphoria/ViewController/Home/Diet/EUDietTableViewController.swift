//
//  EUDietTableViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/4/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUDietTableViewController: UITableViewController {

    @IBOutlet weak var homeButton: UIButton!

    private let disposeBag = DisposeBag()
    let diets: [EUDiet] = [EUDiet(title: "F", detail: "Fruits"), EUDiet(title: "V", detail: "Vegetables"), EUDiet(title: "C", detail: "Cereals"), EUDiet(title: "M", detail: "Meat"), EUDiet(title: "F", detail: "Fish")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setToolBarColor()
        self.tableView.tableFooterView = UIView()
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUDietListViewController, let diet = sender as? EUDiet {
            viewController.diet = diet
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DietCell", for: indexPath) as! EUDietTableViewCell
        let diet = self.diets[indexPath.row]
        cell.titleLabel.text = diet.title
        cell.detailLabel.text = diet.detail
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diet = self.diets[indexPath.row]
        self.performSegue(withIdentifier: "ShowDietListView", sender: diet)
    }
}

class EUDietTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}

