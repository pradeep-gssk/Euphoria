//
//  UIViewController+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func removeNavigationBarBackTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func showLoadingScreen() {
        if let navigationController = self.navigationController {
            MBProgressHUD.showAdded(to: navigationController.view, animated: true)
        }
        else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideLoadingScreen() {
        if let navigationController = self.navigationController {
            MBProgressHUD.hide(for: navigationController.view, animated: true)
        }
        else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showAlertWithMessage(_ message: String) {
        let alert = UIAlertController(title: "Euphoria", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            
        }))
        self.navigationController?.present(alert, animated: true, completion: {
        })
    }
    
//    func stretchBlueImage(_ imageView: UIImageView) {
//        if let image = UIImage(named: "titleBlue") {
//            self.stretchTitleImage(image, imageView: imageView)
//        }
//    }
//
//    private func stretchTitleImage(_ image: UIImage, imageView: UIImageView) {
//        imageView.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), resizingMode: .stretch)
//    }
    
    func setToolBarColor() {
        if #available(iOS 11.0, *) {
            self.navigationController?.toolbar.barTintColor = UIColor(named: "toolBarColor")
        } else {
            self.navigationController?.toolbar.barTintColor = UIColor(red: (250.0/255.0), green: (250.0/255.0), blue: (250.0/255.0), alpha: 0.9)
        }
    }
}
