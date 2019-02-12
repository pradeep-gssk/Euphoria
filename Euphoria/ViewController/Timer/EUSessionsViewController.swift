//
//  EUSessionsViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUSessionsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sessionsTableView: UITableView!
    
    var sessions: [Session] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.sessionsTableView.tableFooterView = UIView()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUTimerSetupViewController {
            viewController.index = Int16(self.sessions.count)
        }
    }
}

extension EUSessionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! EUSessionsTableViewCell
        let session = self.sessions[indexPath.row]
        cell.title.text = session.name
        cell.timer.text = session.time.duration
        return cell
    }
}

extension EUSessionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class EUSessionsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timer: UILabel!
}
