//
//  EULayoutSettings.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

enum HomeType: Int {
    case Questionnaires
    case Diet
    case Exercises
    case Activities
    case History
    case Gallery
    case Timer
    case Settings
    case Videos
    case Other
    
    var items: [EUItem] {
        
        switch self {
        case .Questionnaires:
            return [EUItem(title: "Q1", detail: "Questionnaire 1"), EUItem(title: "Q2", detail: "Questionnaire 2"), EUItem(title: "Q3", detail: "Questionnaire 3"), EUItem(title: "Q4", detail: "Questionnaire 4"), EUItem(title: "Q5", detail: "Questionnaire 5")]
            
        case .Diet:
            return [EUItem(title: "F", detail: "Fruits"), EUItem(title: "V", detail: "Vegetables"), EUItem(title: "C", detail: "Cereals"), EUItem(title: "M", detail: "Meat"), EUItem(title: "F", detail: "Fish")]
            
        case .Exercises:
            return [EUItem(title: "Y", detail: "Yoga"), EUItem(title: "P", detail: "Pilates"), EUItem(title: "R", detail: "Running"), EUItem(title: "C", detail: "Climbing"), EUItem(title: "Q", detail: "Qi Gong"), EUItem(title: "S", detail: "Stretching")]
            
        case .Activities:
            return [EUItem(title: "C", detail: "my Calendar")]
            
        case .History:
            return [EUItem(title: "F", detail: "my Face"), EUItem(title: "T", detail: "my Tongue")]
            
        case .Gallery:
            return [EUItem(title: "V", detail: "Videos"), EUItem(title: "O", detail: "Other")]
            
        case .Settings:
            return [EUItem(title: "A", detail: "my Account"), EUItem(title: "S", detail: "Sign in options"), EUItem(title: "S", detail: "Sync your settings")]
            
        case .Videos:
            return [EUItem(title: "C", detail: "Our concept"), EUItem(title: "D", detail: "Diet Therapy"), EUItem(title: "E", detail: "Exercises"), EUItem(title: "M", detail: "Mind Work"), EUItem(title: "A", detail: "Activities")]

        default:
            return []
        }
    }
    
    var title: String {
        switch self {
        case .Questionnaires:
            return "QUESTIONNAIRES"
            
        case .Diet:
            return "DIET"
            
        case .Exercises:
            return "EXERCISES"
            
        case .Activities:
            return "ACTIVITIES"
            
        case .History:
            return "HISTORY"
            
        case .Gallery:
            return "GALLERY"
            
        case .Settings:
            return "SETTINGS"
            
        case .Videos:
            return "VIDEOS"
            
        default:
            return ""
        }
    }
}


struct EULayoutSettings {
    var titleViewSize: CGSize
    var title: String
    var titleImage: UIImage?
    var detail: String?
    var cellLayout: EUCellLayoutSettings
    var homeType: HomeType
    var items: [EUItem]
    
    init(titleViewSize: CGSize,
         title: String,
         titleImage: UIImage?,
         detail: String?,
         cellLayout: EUCellLayoutSettings,
         homeType: HomeType,
         items: [EUItem]) {
        self.titleViewSize = titleViewSize
        self.title = title
        self.titleImage = titleImage
        self.detail = detail
        self.cellLayout = cellLayout
        self.homeType = homeType
        self.items = items
    }
}

struct EUCellLayoutSettings {
    var ovalImage: UIImage?
    var rectImage: UIImage?
    
    init(ovalImage: UIImage?,
         rectImage: UIImage?) {
        self.ovalImage = ovalImage
        self.rectImage = rectImage
    }
}
