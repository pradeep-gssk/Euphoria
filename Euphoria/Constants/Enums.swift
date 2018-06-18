//
//  Enums.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

enum UserType : String {
    case Doctor = "doctor"
    case Patient = "patient"
}

enum LoginType : String {
    case GENERAL = "general"
    case FACEBOOK = "facebook"
}

enum HtmlViewType : String {
    case Concent = "Concent"
    case Privacy = "Privacy"
    
    var description : String {
        get {
            return self.rawValue
        }
    }
}
