//
//  UIViewController+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

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
    
    
}
