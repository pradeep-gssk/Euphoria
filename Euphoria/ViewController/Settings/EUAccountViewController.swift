//
//  EUAccountViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUAccountViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    private let disposeBag = DisposeBag()
    
    let titles = ["First name:", "Last Name:", "Date of birth:", "E-mail:", "Device:"]
    let values = ["Blabla", "Blablabla", "10/10/1980", "blabla@gmail.com", "iPhone 8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1).cgColor
        self.bottomView.layer.borderWidth = 1
        self.editButton.titleLabel?.textAlignment = .center
        
        self.homeButton.rx.tap.bind(onNext: {
            self.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.bind(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
}

extension EUAccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! EUAccountViewCell
        cell.titleLabel.text = self.titles[indexPath.row]
        cell.detailLabel.text = self.values[indexPath.row]
        return cell
    }
}

class EUAccountViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}
