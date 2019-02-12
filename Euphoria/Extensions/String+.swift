//
//  String+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

extension String {
    var boolValue: Bool {
        return self == "Yes" ? true : false
    }
}

extension TimeInterval {
    var duration: String {
        let hours = Int(self / 3600)
        let minutes = Int((self.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%02d:%02d", hours, minutes)
    }
}
