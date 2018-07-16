//
//  EUTimerModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUTimerModel: EUViewModel {
    var layoutSettings: EULayoutSettings
    var selectedListItem: PublishSubject<EUItem?> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return self.selectedListItem.unwrap().map({ (item) -> (LCFNavigation, UIViewController) in
            let viewController = UIViewController.getViewController(storyboard: "Timer", identifier: "SessionsViewController") as! EUSessionsViewController
            return (LCFNavigation.push, viewController)
        })
    }
    
    init(layoutSettings: EULayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
