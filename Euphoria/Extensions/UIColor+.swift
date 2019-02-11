//
//  UIColor+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

extension UIColor {
    class func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }
    
    class func singleColor(value: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (value/255.0), green: (value/255.0), blue: (value/255.0), alpha: alpha)
    }
}
