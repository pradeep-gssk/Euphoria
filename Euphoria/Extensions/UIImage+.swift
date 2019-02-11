//
//  UIImage+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

extension UIImage {
    
    func stretch() -> UIImage {
        return self.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), resizingMode: .stretch)
    }
}
