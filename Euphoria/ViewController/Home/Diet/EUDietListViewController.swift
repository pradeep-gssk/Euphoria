//
//  EUDietListViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/4/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUDietListViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var dietTableView: UITableView!
    
    let indexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let animals: [String: [String]] = ["A": ["Alligator", "African Bush Elephant", "Aardvark"],
                                       "B": [],
                                       "C": ["Camel", "Cockatoo"],
                                       "D": ["Dog", "Donkey"],
                                       "E": ["Emu"],
                                       "F": ["Falcon", "Ferret"],
                                       "G": ["Giraffe", "Greater Rhea"],
                                       "H": ["Hippopotamus", "Horse"],
                                       "I": ["Impala"],
                                       "J": ["Jackal", "Jaguar"],
                                       "K": ["Koala"],
                                       "L": ["Lion", "Llama"],
                                       "M": ["Manatus", "Meerkat"],
                                       "N": ["Numbat", "Nyala"],
                                       "O": ["Ocelot", "Okapi"],
                                       "P": ["Panda", "Peacock", "Pig", "Platypus", "Polar Bear"],
                                       "Q": ["Quokka", "Quoll"],
                                       "R": ["Rhinoceros"],
                                       "S": ["Seagull"],
                                       "T": ["Tasmania Devil"],
                                       "U": ["Urial", ""],
                                       "V": ["Vole", "Viper", "Vulture"],
                                       "W": ["Whale", "Whale Shark", "Wombat"],
                                       "X": ["Xenons"],
                                       "Y": ["Yak"],
                                       "Z": ["Zebra", "Zebu"]]
    
    

    var diet: EUDiet = EUDiet()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = self.diet.detail
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EUDietListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.indexes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let string = self.indexes[section]
        return self.animals[string]!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.indexes[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.indexes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let string = self.indexes[indexPath.section]
        let animalsArray = self.animals[string]
        cell.textLabel?.text = animalsArray?[indexPath.row]
        return cell
    }
    
    
}

