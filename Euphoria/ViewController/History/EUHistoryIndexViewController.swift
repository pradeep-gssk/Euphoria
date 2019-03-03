//
//  EUHistoryIndexViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUHistoryIndexViewController: UIViewController {

    var historyType: HistoryType!
    
    var historyDictionary = [String: [History]]()
    var historySectionTitles = [String]()
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datesTableView: UITableView!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designViews()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = self.historyType.title
        self.datesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadHistories()
        self.datesTableView.reloadData()
    }
    
    func loadHistories() {
        self.historyDictionary.removeAll()
        self.historySectionTitles.removeAll()
        let histories = CoreDataHelper.shared.fetchHistory(self.historyType.image)
        for history in histories {
            let key = ((history.date as Date?)?.monthYearString) ?? "####"
            if var values = historyDictionary[key] {
                values.append(history)
                historyDictionary[key] = values
            }
            else {
                historySectionTitles.append(key)
                historyDictionary[key] = [history]
            }
        }
    }
    
    func designViews() {
        self.cameraButton.backgroundColor = UIColor.color(red: 243.0, green: 239.0, blue: 234.0, alpha: 1)
        self.cameraButton.layer.shadowColor = UIColor.black.cgColor
        self.cameraButton.layer.shadowOpacity = 0.6
        self.cameraButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.cameraButton.layer.masksToBounds = true
        self.cameraButton.layer.cornerRadius = 55.0/2
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapCameraIcon(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowTakePhotoView", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as EUHistoryShowViewController:
            viewController.historyType = historyType
            viewController.history = sender as? History
        case let viewController as EUHistoryPhotoViewController:
            viewController.historyType = historyType
        default:
            break
        }
    }
}

extension EUHistoryIndexViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.historySectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = historySectionTitles[section]
        if let values = historyDictionary[key] {
            return values.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndexCell", for: indexPath) as! EUIndexListViewCell
        let key = historySectionTitles[indexPath.section]
        let history = historyDictionary[key]?[indexPath.row]
        cell.titleLabel.text = (history?.date as Date?)?.dateMonthString
        return cell
    }
}

extension EUHistoryIndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.historySectionTitles
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexItem = self.historySectionTitles[section]
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 40))
        view.backgroundColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1.0)
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 110, height: 40))
        label.font = UIFont(name: "GillSans-SemiBold", size: 18)
        label.textColor = UIColor.white
        label.text = indexItem
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = historySectionTitles[indexPath.section]
        let history = historyDictionary[key]?[indexPath.row]
        self.performSegue(withIdentifier: "ShowHistoryPhoto", sender: history)
    }
}

class EUIndexListViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
