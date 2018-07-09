//
//  EUVideosCollectionModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUVideosCollectionModel: EUViewModel {
    var layoutSettings: EULayoutSettings
    var selectedListItem: PublishSubject<EUItem?> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return self.selectedListItem.map({ (item) -> (LCFNavigation, UIViewController) in
            let viewModel = self.getVideosModel()
            let viewController = UIViewController.getVideoViewController(viewModel: viewModel)
            return (LCFNavigation.push, viewController)
        })
    }
    
    func getVideosModel() -> EUVideoViewModel {
        let cellLayout = self.layoutSettings.cellLayout
        let layoutSettings = EULayoutSettings(titleViewSize: self.layoutSettings.titleViewSize, title: HomeType.Videos.title, titleImage: self.layoutSettings.titleImage, detail: self.layoutSettings.detail, cellLayout: cellLayout, homeType: .Videos, items: [])
        return EUVideoViewModel(layoutSettings: layoutSettings)
    }
    
    init(layoutSettings: EULayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
