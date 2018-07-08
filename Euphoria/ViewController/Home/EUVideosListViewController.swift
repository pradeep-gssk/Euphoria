//
//  EUVideosListViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUVideosListViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        self.titleLabel.text = viewModel.layoutSettings.title
        self.titleImageView.image = viewModel.layoutSettings.titleImage
        self.titleView.frame = CGRect(origin: .zero, size: viewModel.layoutSettings.titleViewSize)
        self.detailLabel.text = viewModel.layoutSettings.detail
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width-100)/3
        flowLayout.itemSize = CGSize(width: width, height: width + 35)
        flowLayout.minimumLineSpacing = 25
        flowLayout.sectionInset = UIEdgeInsetsMake(25, 25, 25, 25)
        self.collectionView.collectionViewLayout = flowLayout
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
}

extension EUVideosListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosListCell", for: indexPath) as! EUVideosListCollectionViewCell
        cell.bgImage.image = UIImage(named: "photoRed")
        cell.playImage.image = UIImage(named: "playGreen")
        cell.name.text = "Exercise"
        return cell
    }
}

extension EUVideosListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

class EUVideosListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var name: UILabel!
}
