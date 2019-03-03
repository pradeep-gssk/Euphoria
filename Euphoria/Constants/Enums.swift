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

enum HistoryType: Int {
    case face = 0
    case tongue = 1
    
    var title: String {
        switch self {
        case .face:
            return "my Face"
        case .tongue:
            return "my Tongue"
        }
    }
    
    var image: String {
        switch self {
        case .face:
            return "myFace"
        case .tongue:
            return "myTongue"
        }
    }
    
    var placeholder: String {
        switch self {
        case .face:
            return "facePlaceholder"
        case .tongue:
            return "tonguePlaceholder"
        }
    }
    
    var emailSubject: String {
        switch self {
        case .face:
            return "Face Image"
        case .tongue:
            return "Tongue Image"
        }
    }
    
    var emailMessage: String {
        switch self {
        case .face:
            return "<html><body><p>This is Face Image</p></body></html>"
        case .tongue:
            return "<html><body><p>This is Tongue Image</p></body></html>"
        }
    }
}

enum Taoist: String {
    case Earth = "Earth"
    case Water = "Water"
    case Wood = "Wood"
    case Fire = "Fire"
    case Metal = "Metal"
    
    static let allValues = [Earth, Water, Wood, Fire, Metal]
}

enum DietType: String {
    case fruit = "Fruits"
    case vegetables = "Vegetables"
    case nuts = "Nuts-Seeds-Beans"
    case meat = "Meat-Fish"
    case herbs = "Herbs-Spices"
    case grains = "Grains"
    case dairy = "Dairy-Other"
    
    var dietString: String {
        switch self {
        case .fruit:
            return "Fruits"
        case .vegetables:
            return "Vegetables"
        case .nuts:
            return "Nuts, Seeds & Beans"
        case .meat:
            return "Meat & Fish"
        case .herbs:
            return "Herbs & Spices"
        case .grains:
            return "Grains"
        case .dairy:
            return "Dairy & Other"
        }
    }
    
    var firstCharacter: String {
        switch self {
        case .fruit:
            return "F"
        case .vegetables:
            return "V"
        case .nuts:
            return "N"
        case .meat:
            return "M"
        case .herbs:
            return "H"
        case .grains:
            return "G"
        case .dairy:
            return "D"
        }
    }
}
