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
    case activities
    case history
    case gallery
    case timer
    
    var storyboard: String {
        switch self {
        case .questionnaires:
            return "Questionnaires"
        case .diet:
            return "Diet"
        case .exercises:
            return "Exercises"
        case .activities:
            return "Activities"
        case .history:
            return "History"
        case .gallery:
            return "Gallery"
        case .timer:
            return "Timer"
        }
    }
    
    var identifier: String {
        switch self {
        case .questionnaires:
            return "QuestionnaireListView"
        case .diet:
            return "DietListView"
        case .exercises:
            return "ExercisesListView"
        case .activities:
            return "ActivitiesListView"
        case .history:
            return "HistoryListView"
        case .gallery:
            return "GalleryListView"
        case .timer:
            return "TimerListView"
        }
    }
}

enum OptionType: Int {
    case never = 0
    case toggle = 1
    case always = 2
}
