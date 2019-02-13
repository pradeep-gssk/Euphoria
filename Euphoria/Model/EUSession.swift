//
//  EUSession.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

class EUSession: NSObject {
    let name: String
    let index: Int16
    let time: Double
    var stops: [EUStop] = []
    var sounds: [Sound] = []
    
    init(name: String, index: Int16, time: Double) {
        self.name = name
        self.index = index
        self.time = time
    }
}

struct EUStop {
    let index: Int16
    let time: Double
    
    init(index: Int16, time: Double) {
        self.index = index
        self.time = time
    }
}
