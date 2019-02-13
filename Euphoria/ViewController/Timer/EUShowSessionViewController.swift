//
//  EUShowSessionViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUShowSessionViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sessionTableView: UITableView!
    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    
    var session: Session!
    var stops: [Stop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.sessionName.text = session.name
        self.sessionTime.text = session.time.duration
        self.sessionTableView.tableFooterView = UIView()
        self.stops = self.session.stops?.allObjects as? [Stop] ?? []
        self.stops.sort { (stop1, stop2) -> Bool in
            return stop1.index < stop2.index
        }
    }

    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EUShowSessionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.stops.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stop = self.stops[indexPath.section]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! EUSessionStopTableViewCell
            cell.time.text = stop.time.duration
            cell.title.text = "Session \(indexPath.section + 1)"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! EUSessionSoundTableViewCell
        cell.sound.text = stop.sound
        return cell
    }
}
