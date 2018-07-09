//
//  EUVideoViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUVideoViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoDetail: UITextView!
    @IBOutlet weak var slider: UISlider!
    
    var viewModel: EUViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = self.viewModel else { return }
        
        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.searchField.layer.borderColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1).cgColor
        self.searchField.layer.borderWidth = 1
        self.searchField.setPaddingPointsOnLeft(14, andRight: 14)
        self.videoDetail.isScrollEnabled = false
        
        self.titleLabel.text = viewModel.layoutSettings.title
        self.titleImageView.image = viewModel.layoutSettings.titleImage
        self.titleView.frame = CGRect(origin: .zero, size: viewModel.layoutSettings.titleViewSize)
        self.detailLabel.text = viewModel.layoutSettings.detail
                
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.videoDetail.isScrollEnabled = true
    }
}
