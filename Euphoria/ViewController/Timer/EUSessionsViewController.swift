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

        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.sessionsTableView.tableFooterView = UIView()
        self.sessions = CoreDataHelper.shared.fetchSessions()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUTimerSetupViewController {
            viewController.index = Int16(self.sessions.count)
        }
        else if let viewController = segue.destination as? EUShowSessionViewController,
            let session = sender as? Session {
            viewController.session = session
        }
    }
    
    @IBAction func unwindToSessions(_ sender: UIStoryboardSegue) {
        self.sessions = CoreDataHelper.shared.fetchSessions()
        self.sessionsTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let session = self.sessions[indexPath.row]
            CoreDataHelper.shared.deleteSession(session)
            self.sessions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension EUSessionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let session = self.sessions[indexPath.row]
        self.performSegue(withIdentifier: "ShowSessionDetail", sender: session)
    }
}

class EUSessionsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timer: UILabel!
}
