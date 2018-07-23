//
//  EUSessionDetailsViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/22/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUSessionDetailsViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var sessionTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var session = EUSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionTableView.tableFooterView = UIView()
        
        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
        
        self.sessionTableView.cellLayoutMarginsFollowReadableWidth = false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUTimerCountDownViewController {
            viewController.session = session
        }
    }
}

extension EUSessionDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! EUSessionDetailsTableViewCell
            cell.title.text = session.session
            cell.timer.text = session.countDownDuration.duration
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StartCell", for: indexPath) as! EUSessionDetailsTableViewCell
            cell.title.text = "Start"
            cell.timer.text = session.countDownDuration.duration
            return cell
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! EUSessionDetailsTableViewCell
            cell.title.text = "Stop"
            cell.timer.text = "00:00"
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! EUSessionDetailsTableViewCell
        cell.title.text = "Sound"
        cell.timer.text = "List"
        return cell
    }
}

extension EUSessionDetailsViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: "ShowTimerCountDown", sender: self)
        }
    }
    
}

class EUSessionDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timer: UILabel!
}
