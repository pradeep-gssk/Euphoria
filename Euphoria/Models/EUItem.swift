//
//  EUItem.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

struct EUItem {
    var title: String = ""
    var detail: String = ""
    var identifier: String = ""
    
    init() {
    }
    
    init(title: String, detail: String, identifier: String = "") {
        self.title = title
        self.detail = detail
        self.identifier = identifier
    }
}


struct EUIndexItem {
    var title: String = ""
    var items: [EUItem] = []
    
    init() {
    }
    
    init(title: String, items: [EUItem]) {
        self.title = title
        self.items = items
    }
}
