//
//  EUViewModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

protocol EUViewModel: class {
    var layoutSettings: EULayoutSettings { get }
    var selectedListItem: PublishSubject<EUItem?> { get }
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> { get }
}


protocol EUIndexViewModel: class {
    var layoutSettings: EUIndexLayoutSettings { get }
    var selectedListItem: PublishSubject<EUItem?> { get }
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> { get }
}
