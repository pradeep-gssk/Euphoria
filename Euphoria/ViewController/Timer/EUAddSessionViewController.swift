//
//  EUAddSessionViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUAddSessionViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sessionTableView: UITableView!
    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var transparentView: UIView!
    
    var session: EUSession!
    var numberOfSections = 0
    var remainingSelectedInterval: TimeInterval = 0
    var currentSelectedInterval: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.sessionName.text = session.name
        self.sessionTime.text = session.time.duration
        self.sessionTableView.tableFooterView = UIView()
        self.remainingSelectedInterval = self.session.time
        self.saveButton.isHidden = true
        self.transparentView.isHidden = true
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        //Check for conditions
        self.addButton.isEnabled = false
        self.numberOfSections += 1
        
        self.sessionTableView.beginUpdates()
        self.sessionTableView.insertSections([self.numberOfSections-1], with: .bottom)
        self.sessionTableView.endUpdates()
        self.sessionTableView.scrollToRow(at: IndexPath(row: 1, section: self.numberOfSections-1), at: .bottom, animated: true)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        CoreData.sharedInstance.saveSession(self.session)
        self.performSegue(withIdentifier: "GoToSessionsView", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUSoundsViewController,
            let indexPath = sender as? IndexPath {
            viewController.selectedSound = {(sound: Sound) -> Void in
                self.saveSound(indexPath, sound: sound)
            }
        }
    }
    
    func saveSound(_ indexPath: IndexPath, sound: Sound)  {
        self.session.sounds.append(sound)
        if self.remainingSelectedInterval > 0,
            self.session.stops.indices.contains(indexPath.section) {
            self.addButton.isEnabled = true
        }
        self.updateActionButtons()
        self.sessionTableView.beginUpdates()
        self.sessionTableView.reloadRows(at: [indexPath], with: .automatic)
        self.sessionTableView.endUpdates()
    }
    
    func updateActionButtons() {
        if self.remainingSelectedInterval <= 0,
            self.session.stops.count == self.session.sounds.count {
            self.addButton.isHidden = true
            self.saveButton.isHidden = false
        }
    }
}

extension EUAddSessionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! EUSessionStopTableViewCell
            if self.session.stops.indices.contains(indexPath.section) {
                let stop = self.session.stops[indexPath.section]
                cell.time.text = stop.time.duration
            }
            
            cell.index = indexPath.section
            cell.title.text = "Session \(indexPath.section + 1)"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! EUSessionSoundTableViewCell
        if self.session.sounds.indices.contains(indexPath.section) {
            let sound = self.session.sounds[indexPath.section]
            cell.sound.text = sound.name
        }
        else {
            cell.sound.text = "List"
        }
        return cell
    }
}

extension EUAddSessionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! EUSessionStopTableViewCell
            let filter = self.session.stops.filter { (stop) -> Bool in
                return stop.index == indexPath.section
            }
            
            if filter.count > 0, let stop = filter.first {
                cell.timePicker.timeInterval = stop.time + 60
                self.remainingSelectedInterval += stop.time
            }
            else {
                cell.timePicker.timeInterval = 0
            }
            
            cell.timePicker.maxTimeInterval = self.remainingSelectedInterval
            cell.timePicker.onTimeIntervalChanged = {( _ newTimeInterval: TimeInterval) -> Void in
                cell.time.text = newTimeInterval.duration
                self.currentSelectedInterval = newTimeInterval
            }
            cell.doneButtonTapped = {
                self.saveStop(cell)
            }
            _ = cell.becomeFirstResponder()
            self.transparentView.isHidden = false
            return
        }
        
        self.performSegue(withIdentifier: "ShowSoundsList", sender: indexPath)
    }
    
    func saveStop(_ cell: EUSessionStopTableViewCell)  {
        guard self.currentSelectedInterval > 0 else {
            //TODO: Show error
            return
        }
        self.remainingSelectedInterval = self.remainingSelectedInterval - self.currentSelectedInterval
        let stop = EUStop(index: Int16(cell.index), time: self.currentSelectedInterval)
        
        let filter = self.session.stops.filter { (stop) -> Bool in
            return stop.index == cell.index
        }
        
        if filter.count > 0 {
            self.session.stops[cell.index] = stop
        }
        else {
            self.session.stops.append(stop)
        }
        self.transparentView.isHidden = true
        _ = cell.resignFirstResponder()
        cell.timePicker.reset()
        if self.remainingSelectedInterval > 0,
            self.session.sounds.indices.contains(cell.index) {
            self.addButton.isEnabled = true
        }
        self.updateActionButtons()
    }
}

class EUSessionStopTableViewCell: ResponderTableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
}

class EUSessionSoundTableViewCell: UITableViewCell {
    @IBOutlet weak var sound: UILabel!
}
