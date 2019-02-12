//
//  EUSessionViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUSessionViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sessionTableView: UITableView!
    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    
    var session: EUSession!
    var numberOfSections = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.sessionName.text = session.name
        self.sessionTime.text = session.time.duration
        self.sessionTableView.tableFooterView = UIView()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        //Check for conditions
        
        self.numberOfSections += 1
        self.sessionTableView.reloadData()
    }
}

extension EUSessionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! EUSessionStopTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! EUSessionSoundTableViewCell
        return cell
    }
}

extension EUSessionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            return
        }
    }
}

class EUSessionStopTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
}

class EUSessionSoundTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sound: UILabel!
}
