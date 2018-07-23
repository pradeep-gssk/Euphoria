//
//  String+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import CoreGraphics

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "euphoria", bundle: Bundle.main, value: "", comment: "")
    }
}

extension TimeInterval {
    
    var duration: String {
        let hours = Int(self / 3600)
        let minutes = Int((self.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%02d:%02d", hours, minutes)
    }
}

extension CGFloat {
    var duration: String {
        let hours = Int(self / 3600)
        let minutes = Int((self.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Array {
    
    mutating func append(element: Element) {
        self.append(element)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(encodedData, forKey: SESSIONS)
    }
}
