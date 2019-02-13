//
//  EUHistory.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

struct EUHistory {
    var title: String = ""
    
    init() {
    }
    
    init(title: String) {
        self.title = title
    }
}

struct EUIndexItem {
    var title: String = ""
    var items: [EUHistory] = []
    
    init() {
    }
    
    init(title: String, items: [EUHistory]) {
        self.title = title
        self.items = items
    }
}

let indexItems = [EUIndexItem(title: "Jan, 2018", items: [EUHistory(title: "January 10, 2018, 08:00"),
                                                          EUHistory(title: "January 20, 2018, 10:00"),
                                                          EUHistory(title: "January 30, 2018, 12:00")]),
                  EUIndexItem(title: "Feb, 2018", items: [EUHistory(title: "February 10, 2018, 08:00"),
                                                          EUHistory(title: "February 20, 2018, 10:00"),
                                                          EUHistory(title: "February 25, 2018, 12:00")]),
                  EUIndexItem(title: "Mar, 2018", items: [EUHistory(title: "March 10, 2018, 08:00"),
                                                          EUHistory(title: "March 20, 2018, 10:00"),
                                                          EUHistory(title: "March 30, 2018, 12:00")]),
                  EUIndexItem(title: "Apr, 2018", items: [EUHistory(title: "April 10, 2018, 08:00"),
                                                          EUHistory(title: "April 20, 2018, 10:00"),
                                                          EUHistory(title: "April 30, 2018, 12:00")]),
                  EUIndexItem(title: "May, 2018", items: [EUHistory(title: "May 10, 2018, 08:00"),
                                                          EUHistory(title: "May 20, 2018, 10:00"),
                                                          EUHistory(title: "May 30, 2018, 12:00")]),
                  EUIndexItem(title: "Jun, 2018", items: [EUHistory(title: "June 10, 2018, 08:00"),
                                                          EUHistory(title: "June 20, 2018, 10:00"),
                                                          EUHistory(title: "June 30, 2018, 12:00")]),
                  EUIndexItem(title: "Jul, 2018", items: [EUHistory(title: "July 10, 2018, 08:00"),
                                                          EUHistory(title: "July 20, 2018, 10:00"),
                                                          EUHistory(title: "July 30, 2018, 12:00")]),
                  EUIndexItem(title: "Aug, 2018", items: [EUHistory(title: "August 10, 2018, 08:00"),
                                                          EUHistory(title: "August 20, 2018, 10:00"),
                                                          EUHistory(title: "August 30, 2018, 12:00")]),
                  EUIndexItem(title: "Sep, 2018", items: [EUHistory(title: "September 10, 2018, 08:00"),
                                                          EUHistory(title: "September 20, 2018, 10:00"),
                                                          EUHistory(title: "September 30, 2018, 12:00")]),
                  EUIndexItem(title: "Oct, 2018", items: [EUHistory(title: "October 10, 2018, 08:00"),
                                                          EUHistory(title: "October 20, 2018, 10:00"),
                                                          EUHistory(title: "October 30, 2018, 12:00")]),
                  EUIndexItem(title: "Nov, 2018", items: [EUHistory(title: "November 10, 2018, 08:00"),
                                                          EUHistory(title: "November 20, 2018, 10:00"),
                                                          EUHistory(title: "November 30, 2018, 12:00")]),
                  EUIndexItem(title: "Dec, 2018", items: [EUHistory(title: "December 10, 2018, 08:00"),
                                                          EUHistory(title: "December 20, 2018, 10:00"),
                                                          EUHistory(title: "December 30, 2018, 12:00")])]

let indexes = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
