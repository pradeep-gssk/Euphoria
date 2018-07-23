//
//  EUSessionsViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/16/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUSessionsViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var sessionsTableView: UITableView!
    
    let sessions = appDelegate.sessions
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUSessionDetailsViewController, let session = sender as? EUSession {
            viewController.session = session
        }
    }
}

extension EUSessionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewSessionCell", for: indexPath) as! EUSessionsTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! EUSessionsTableViewCell
        let session = self.sessions[indexPath.row]
        cell.title.text = session.session
        cell.timer.text = session.countDownDuration.duration
        return cell
    }
}

extension EUSessionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "ShowSetTimer", sender: self)
        }
        else {
            let session = self.sessions[indexPath.row]
            self.performSegue(withIdentifier: "ShowSessionDetail", sender: session)
        }
    }
}

class EUSessionsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timer: UILabel!
}
