//
//  EUOtherModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUOtherModel: EUViewModel {
    var layoutSettings: EULayoutSettings
    var selectedListItem: PublishSubject<EUItem?> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return Observable.empty()
    }
    
    init(layoutSettings: EULayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
