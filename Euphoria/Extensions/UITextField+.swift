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
}
