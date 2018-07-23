//
//  EUSession.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/22/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation


class EUSession: NSObject, NSCoding {
    var session: String = ""
    var countDownDuration: TimeInterval = 0
    
    override init() {
    }
    
    init(session: String, countDownDuration: TimeInterval) {
        self.session = session
        self.countDownDuration = countDownDuration
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.session, forKey: "session")
        aCoder.encode(NSNumber(value: self.countDownDuration), forKey: "countDownDuration")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.session = aDecoder.decodeObject(forKey: "session") as? String ?? ""
        let duration = aDecoder.decodeObject(forKey: "countDownDuration") as? NSNumber
        self.countDownDuration = duration?.doubleValue ?? 0 //aDecoder.decodeObject(forKey: "countDownDuration") as? TimeInterval ?? 0
    }

}
