//
//  EUNavigationController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/24/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationBar.barTintColor = UIColor(named: "navBarColor")
        } else {
            self.navigationBar.barTintColor = UIColor(red: (243.0/255.0), green: (239.0/255.0), blue: (234.0/255.0), alpha: 1.0)
        }
    }
}
