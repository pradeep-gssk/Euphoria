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
    
    func resizeImage(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImageView {
    func loadUserImage() {
        guard let customerId = EUUser.user?.customerId,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
        }
        
        let filePath = documentsDirectory.appendingPathComponent("\(customerId)").path
        if FileManager.default.fileExists(atPath: filePath) {
            self.image = UIImage(contentsOfFile: filePath)
        }
    }
}

extension UIButton {
    func loadUserImage() {
        guard let customerId = EUUser.user?.customerId,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
        }
        self.imageView?.contentMode = .center
        self.imageView?.layer.cornerRadius = 15
        self.imageView?.layer.masksToBounds = true
        let filePath = documentsDirectory.appendingPathComponent("\(customerId)").path
        if FileManager.default.fileExists(atPath: filePath) {
            let image = UIImage(contentsOfFile: filePath)?.resizeImage(newWidth: 40)
            self.setImage(image, for: .normal)
        }
    }
}
