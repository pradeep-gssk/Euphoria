//
//  Enums.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

enum HtmlViewType: String {
    case Concent = "Concent"
    case Privacy = "Privacy"
    
    var description: String {
        get {
            return self.rawValue
        }
    }
    
    var title: String {
        switch self {
        case .Concent:
            return "I AGREE"
        case .Privacy:
            return "CONFIRM"
        }
    }
}

enum HomeType: Int {
    case questionnaires
    case diet
    case exercises
}

//enum ExercisesType: Int {
//    case yoga
//    case pilates
//    case running
//    case climbing
//    case qiGong
//    case stretching
//}

enum OptionType: Int {
    case never = 0
    case toggle = 1
    case always = 2
}
