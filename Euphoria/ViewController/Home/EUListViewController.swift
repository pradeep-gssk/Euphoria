//
//  EUListViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUListViewController: UITableViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var viewModel: EUViewModel?
    private let disposeBag = DisposeBag()
    private var items = [EUItem]()
    private var cellLayout: EUCellLayoutSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }
        
        self.titleLabel.text = viewModel.layoutSettings.title
        self.titleImageView.image = viewModel.layoutSettings.titleImage
        self.titleView.frame = CGRect(origin: .zero, size: viewModel.layoutSettings.titleViewSize)
        self.items = viewModel.layoutSettings.items
        self.cellLayout = viewModel.layoutSettings.cellLayout
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
        self.bindViewModel()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! EUListViewCell
        cell.accessoryImageView.image = self.cellLayout?.rectImage
        cell.titleImageView.image = self.cellLayout?.ovalImage
        
        let item = self.items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        let item = self.items[indexPath.row]
        viewModel.selectedListItem.onNext(item)
    }
}

extension EUListViewController {
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.navigateToVC.observeOn(MainScheduler.instance).bind(onNext: {(navigation, viewController) in
            self.navigationController?.pushViewController(viewController, animated: true)
        }).disposed(by: disposeBag)
    }
}

class EUListViewCell: UITableViewCell {
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var accessoryImageView: UIImageView!
}
