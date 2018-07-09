//
//  EUIndexModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUIndexModel: EUIndexViewModel {
    var layoutSettings: EUIndexLayoutSettings
    var selectedListItem: PublishSubject<EUItem?> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return Observable.empty()
    }
    
    init(layoutSettings: EUIndexLayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
