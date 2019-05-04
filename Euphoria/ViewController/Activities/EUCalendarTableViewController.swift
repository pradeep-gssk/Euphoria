//
//  EUCalendarTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/25/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import MBCalendarKit

class EUCalendarViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.calendarTableView()
        
    }
    
    func calendarTableView() {
        guard let viewController = self.children.first as? EUCalendarTableViewController else { return }
        viewController.didSelectRowAt = { (activity) -> Void in
            self.performSegue(withIdentifier: "ShowActivityView", sender: activity)
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUActivityViewController,
            let activity = sender as? EUActivity {
            viewController.activity = activity
        }
    }
}

class EUCalendarTableViewController: UITableViewController {

    @IBOutlet weak var calendar: CalendarView!
    var activities: [EUActivity] = []
    var fullActivites: [EUActivity] = []
    var didSelectRowAt: ((_ activity: EUActivity) -> Void)?

    lazy var rectangleLightGreen: UIImage? = {
        return UIImage(named: "rectangleLightGreen")
    }()
    
    lazy var rectangleBeige: UIImage? = {
        return UIImage(named: "rectangleBeige")
    }()
    
    lazy var rectangleBrown: UIImage? = {
        return UIImage(named: "rectangleBrown")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        self.fetchActivities()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendar.layoutIfNeeded()
        print(self.calendar)
    }
    
    func fetchActivities() {
        guard let customerId = EUUser.user?.customerId else { return }
        let router = Router(endpoint: .Activities(customerId: Int64(customerId)))
        
        APIManager.shared.requestActivities(router: router, success: { (result) in
            self.fullActivites = result
            self.filterActivities(Date())
        }, failure: { (error) in
            print(error)
        })
    }
    
    func filterActivities(_ date: Date) {
        let dateString = date.dateMonthYearString
        activities = fullActivites.filter { (activity) -> Bool in
            return activity.appointmentDate == dateString
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath) as! EUCalendarCell
        
        let activity = self.activities[indexPath.row]
        
        switch indexPath.row%3 {
        case 0:
            cell.rectangle.image = rectangleBeige
            
        case 1:
            cell.rectangle.image = rectangleLightGreen
            
        default:
            cell.rectangle.image = rectangleBrown
        }
        
        cell.timeLabel.text = (activity.appointmentStartTime ?? "") + "-" + (activity.appointmentEndTime ?? "")
        cell.titleLabel.text = activity.trtDescription
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = self.activities[indexPath.row]
        self.didSelectRowAt?(activity)
    }
}

extension EUCalendarTableViewController: CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, didSelect date: Date) {
        self.filterActivities(date)
    }
}

class EUCalendarCell: UITableViewCell {

    @IBOutlet weak var rectangle: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}
