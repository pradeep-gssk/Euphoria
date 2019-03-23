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

extension Optional where Wrapped == String {
    var stringValue: String {
        return self ?? ""
    }
}
