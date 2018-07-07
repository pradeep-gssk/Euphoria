//
//  EUDiet.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/4/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

struct EUDiet {
    var title: String = ""
    var detail: String = ""
    
    init() {
    }
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}
