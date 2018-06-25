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

//enum HomeSelection : String {
//    case Questionnaires = "questionnaires"
//    case Diet = "diet"
//    case Exercises = "exercises"
//    case Activities = "activities"
//    case History = "history"
//    case Gallery = "gallery"
//    case Timer = "timer"
//}

enum HtmlViewType : String {
    case Concent = "Concent"
    case Privacy = "Privacy"
    
    var description : String {
        get {
            return self.rawValue
        }
    }
    
    var title : String {
        switch self {
        case .Concent:
            return "I AGREE"
        case .Privacy:
            return "CONFIRM"
        }
    }
}
