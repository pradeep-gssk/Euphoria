//
//  EUDietViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/3/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUDietViewController: UIViewController {

    var diet: Diet?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var organField: UILabel!
    @IBOutlet weak var channelField: UILabel!
    @IBOutlet weak var effectField: UILabel!
    @IBOutlet weak var flavourField: UILabel!
    @IBOutlet weak var natureField: UILabel!
    @IBOutlet weak var taoistField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        if let diet = self.diet?.diet {
            self.titleLabel.text = DietType(rawValue: diet)?.dietString
        }
        
        self.nameField.text = self.diet?.name
        self.organField.text = self.diet?.organ
        self.channelField.text = self.diet?.channels
        self.effectField.text = self.diet?.effect
        self.flavourField.text = self.diet?.flavour
        self.natureField.text = self.diet?.nature
        self.taoistField.text = self.diet?.taoist
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
