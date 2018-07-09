//
//  EUHistoryModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUHistoryModel: EUViewModel {
    
    let items = [EUIndexItem(title: "Jan, 2018", items: [EUItem(title: "January 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "January 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "January 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Feb, 2018", items: [EUItem(title: "February 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "February 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "February 25, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Mar, 2018", items: [EUItem(title: "March 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "March 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "March 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Apr, 2018", items: [EUItem(title: "April 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "April 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "April 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "May, 2018", items: [EUItem(title: "May 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "May 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "May 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Jun, 2018", items: [EUItem(title: "June 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "June 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "June 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Jul, 2018", items: [EUItem(title: "July 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "July 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "July 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Aug, 2018", items: [EUItem(title: "August 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "August 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "August 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Sep, 2018", items: [EUItem(title: "September 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "September 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "September 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Oct, 2018", items: [EUItem(title: "October 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "October 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "October 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Nov, 2018", items: [EUItem(title: "November 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "November 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "November 30, 2018, 12:00", detail: "")]),
                 EUIndexItem(title: "Dec, 2018", items: [EUItem(title: "December 10, 2018, 08:00", detail: ""),
                                                         EUItem(title: "December 20, 2018, 10:00", detail: ""),
                                                         EUItem(title: "December 30, 2018, 12:00", detail: "")])]
    
    let indexes = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    
    var layoutSettings: EULayoutSettings
    var selectedListItem: PublishSubject<EUItem?> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return self.selectedListItem.unwrap().map({ (item) -> (LCFNavigation, UIViewController) in
            let indexViewModel = self.getIndexesModel(item: item)
            let viewController = UIViewController.getIndexViewController(indexViewModel: indexViewModel)
            return (LCFNavigation.push, viewController)
        })
    }
    
    func getIndexesModel(item: EUItem) -> EUIndexModel {
        let layoutSettings = EUIndexLayoutSettings(titleViewSize: self.layoutSettings.titleViewSize, title: self.layoutSettings.title, titleImage: self.layoutSettings.titleImage, detail: item.detail, homeType: self.layoutSettings.homeType, searchPlaceHolder: "Search (YY / MM / DD)", indexes: indexes, items: items)
        return EUIndexModel(layoutSettings: layoutSettings)
     }
    
    init(layoutSettings: EULayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
