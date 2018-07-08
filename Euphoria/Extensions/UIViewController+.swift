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
    
    static func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    static func getListViewController(viewModel: EUViewModel) -> EUListViewController {
        let viewController = self.getViewController(storyboard: "Main", identifier: "ListViewController") as! EUListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func getVideosListViewController(viewModel: EUViewModel) -> EUVideosListViewController {
        let viewController = self.getViewController(storyboard: "Main", identifier: "VideosListViewController") as! EUVideosListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setToolBarColor() {
        if #available(iOS 11.0, *) {
            self.navigationController?.toolbar.barTintColor = UIColor(named: "toolBarColor")
        } else {
            self.navigationController?.toolbar.barTintColor = UIColor(red: (250.0/255.0), green: (250.0/255.0), blue: (250.0/255.0), alpha: 0.9)
        }
    }
}
