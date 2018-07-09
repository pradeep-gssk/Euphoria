//
//  EUIndexListViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUIndexListViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var indexTableView: UITableView!
    
    var indexViewModel: EUIndexViewModel?
    private let disposeBag = DisposeBag()
    private var indexItems = [EUIndexItem]()
    private var indexes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let indexViewModel = self.indexViewModel else { return }
        
        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.searchField.layer.borderColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1).cgColor
        self.searchField.layer.borderWidth = 1
        self.searchField.setPaddingPointsOnLeft(8, andRight: 8)
        
        self.titleLabel.text = indexViewModel.layoutSettings.title
        self.titleImageView.image = indexViewModel.layoutSettings.titleImage
        self.titleView.frame = CGRect(origin: .zero, size: indexViewModel.layoutSettings.titleViewSize)
        self.detailLabel.text = indexViewModel.layoutSettings.detail
        self.searchField.placeholder = indexViewModel.layoutSettings.searchPlaceHolder
        self.indexItems = indexViewModel.layoutSettings.items
        self.indexes = indexViewModel.layoutSettings.indexes
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
}

extension EUIndexListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.indexItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = self.indexItems[section]
        return items.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndexCell", for: indexPath) as! EUIndexListViewCell
        let items = self.indexItems[indexPath.section]
        let item = items.items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.checkmark.image = nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let indexItem = self.indexItems[section]
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 40))
        view.backgroundColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1.0)
        let label = UILabel(frame: CGRect(x: 30, y: 0, width: UIScreen.main.bounds.width - 110, height: 40))
        label.font = UIFont(name: "GillSans-SemiBold", size: 18)
        label.textColor = UIColor.white
        label.text = indexItem.title
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.indexes
    }
}

extension EUIndexListViewController: UITableViewDelegate {
    
}

class EUIndexListViewCell: UITableViewCell {
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
