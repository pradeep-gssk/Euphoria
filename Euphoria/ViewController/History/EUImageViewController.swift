//
//  EUImageViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/16/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUImageViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    private let disposeBag = DisposeBag()
    var item = EUItem()
    var homeType: HomeType?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemTitle.text = self.item.title
        self.navigationController?.isToolbarHidden = true
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
    }

}
