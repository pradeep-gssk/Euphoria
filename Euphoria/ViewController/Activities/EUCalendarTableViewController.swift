//
//  EUCalendarTableViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/25/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import VACalendar

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

    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        return calendar
    }()
    
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM, YYYY"
            let appereance = VAMonthHeaderViewAppearance(monthFont: UIFont(name: "GillSans", size: 18) ?? UIFont.systemFont(ofSize: 18),
                                                         monthTextColor: UIColor.singleColor(value: 129, alpha: 1.0),
                                                         monthTextWidth: UIScreen.main.bounds.width - 100,
                                                         previousButtonImage: #imageLiteral(resourceName: "previous"),
                                                         nextButtonImage: #imageLiteral(resourceName: "next"),
                                                         dateFormatter: dateFormatter)


            monthHeaderView.delegate = self
            monthHeaderView.appearance = appereance
        }
    }

    @IBOutlet weak var weekDaysView: VAWeekDaysView! {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .short, separatorBackgroundColor: UIColor.clear, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    
    var calendarView: VACalendarView!
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
        self.addCalendar()
        self.fetchActivities()
        self.tableView.tableFooterView = UIView()
    }
    
    private func addCalendar() {
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        tableView.tableHeaderView?.addSubview(calendarView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.4
            )
            calendarView.setup()
            self.resetTableHeader()
        }
    }

    private func resetTableHeader() {
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        var frame = headerView.frame
        frame.size.height = calendarView.frame.height + calendarView.frame.origin.y
        headerView.frame = frame
        tableView.tableHeaderView = headerView
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

extension EUCalendarTableViewController: VAMonthHeaderViewDelegate {
    func didTapNextMonth() {
        calendarView.nextMonth()
    }

    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
}

extension EUCalendarTableViewController: VADayViewAppearanceDelegate {
    
    func font(for state: VADayState) -> UIFont {
        return UIFont(name: "GillSans", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }

    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return UIColor.color(red: 189, green: 145, blue: 138, alpha: 1.0)
        default:
            return UIColor.singleColor(value: 251, alpha: 1.0)
        }
    }

    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor.singleColor(value: 204, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return UIColor.singleColor(value: 101, alpha: 1.0)
        }
    }

    func shape() -> VADayShape {
        return .square
    }
}

extension EUCalendarTableViewController: VAMonthViewAppearanceDelegate {

}

extension EUCalendarTableViewController: VACalendarViewDelegate {
    func selectedDate(_ date: Date) {
        self.filterActivities(date)
    }
}

class EUCalendarCell: UITableViewCell {

    @IBOutlet weak var rectangle: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}
