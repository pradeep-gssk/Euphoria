//
//  EUAccountViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUAccountViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var titles = [String]()
    var values = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = EUUser.user {
            titles = ["First name:", "Last Name:", "Phone:", "E-mail:"]
            values.append(user.firstName.stringValue)
            values.append(user.lastName.stringValue)
            values.append(user.phone.stringValue)
            values.append(user.email.stringValue)
        }
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor.singleColor(value: 151.0, alpha: 1).cgColor
        self.bottomView.layer.borderWidth = 1
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: USER_PROFILE_DATA)
        UserDefaults.standard.synchronize()
        appDelegate.showLoginView()
    }
}

extension EUAccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
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
