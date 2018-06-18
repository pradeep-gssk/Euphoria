//
//  UITextField+.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/10/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPaddingPoints(_ amount:CGFloat){
        self.setLeftPaddingPoints(amount)
        self.setRightPaddingPoints(amount)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func desginView() {
        self.setPaddingPoints(14)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.color(red: 74, green: 74, blue: 74, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = 2.0
        self.layer.shouldRasterize = true
        self.layer.shadowOpacity = 1.0
        self.layer.sublayerTransform = CATransform3DMakeTranslation(0, 7, 0)
        
        //myTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    }
}
