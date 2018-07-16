//
//  EUTakePhotoViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/16/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUTakePhotoViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var item = EUItem()
    var homeType: HomeType?
    
    var showDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if showDelete == false {
            self.trashButton.isHidden = true
            self.saveButton.setTitle("SAVE", for: .normal)
            self.saveButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            self.saveButton.setImage(nil, for: .normal)
        }
        
        self.itemTitle.text = self.item.title
        self.navigationController?.isToolbarHidden = true
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
    }
}
