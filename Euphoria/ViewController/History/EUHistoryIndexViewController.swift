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
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = self.historyType.title
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUHistoryPhotoViewController,
            let history = sender as? EUHistory {
            viewController.historyType = historyType
            viewController.history = history
        }
    }
}

extension EUHistoryIndexViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = indexItems[section]
        return items.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndexCell", for: indexPath) as! EUIndexListViewCell
        let items = indexItems[indexPath.section]
        let item = items.items[indexPath.row]
        cell.titleLabel.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexes
    }
}

extension EUHistoryIndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexItem = indexItems[section]
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 40))
        view.backgroundColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1.0)
        let label = UILabel(frame: CGRect(x: 30, y: 0, width: UIScreen.main.bounds.width - 110, height: 40))
        label.font = UIFont(name: "GillSans-SemiBold", size: 18)
        label.textColor = UIColor.white
        label.text = indexItem.title
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = indexItems[indexPath.section]
        let item = items.items[indexPath.row]
        self.performSegue(withIdentifier: "ShowTakePhotoView", sender: item)
    }
}

class EUIndexListViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
