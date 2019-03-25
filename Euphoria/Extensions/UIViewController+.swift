//
//  UIViewController+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func gotoHome() {
        self.performSegue(withIdentifier: "GoToHome", sender: self)
    }
    
    static func getViewController(name: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
        
    var collectionViewFlowLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width-100)/3
        flowLayout.itemSize = CGSize(width: width, height: width + 35)
        flowLayout.minimumLineSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        return flowLayout
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
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                MBProgressHUD.hide(for: navigationController.view, animated: true)
            }
            else {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func showAlertWithMessage(_ message: String, title: String = "Euphoria") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            
        }))
        self.navigationController?.present(alert, animated: true, completion: {
        })
    }
    
    func findElement(_ customerId: Int64) -> Element {
        var selectedElement: Element = .Earth
        var previousValue = 0
        Element.allValues.forEach { (type) in
            let value = CoreDataHelper.shared.getElementCount(forString: type.rawValue, customerId)
            
            if previousValue < value {
                previousValue = value
                selectedElement = type
            }
        }
        return selectedElement
    }
}
