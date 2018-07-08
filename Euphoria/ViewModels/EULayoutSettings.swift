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
