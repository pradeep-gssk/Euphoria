//
//  EUExercisesModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUExercisesModel: EUViewModel {
    var layoutSettings: EULayoutSettings
    var selectedListItem: PublishSubject<EUItem> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return self.selectedListItem.map({ (item) -> (LCFNavigation, UIViewController) in
            let viewModel = self.getVideosModel(item: item)
            let viewController = UIViewController.getVideosListViewController(viewModel: viewModel)
            return (LCFNavigation.push, viewController)
        })
    }
    
    func getVideosModel(item: EUItem) -> EUVideosCollectionModel {
        let cellLayout = self.layoutSettings.cellLayout
        let layoutSettings = EULayoutSettings(titleViewSize: self.layoutSettings.titleViewSize, title: HomeType.Videos.title, titleImage: self.layoutSettings.titleImage, detail: item.detail, cellLayout: cellLayout, homeType: .Videos, items: [])
        return EUVideosCollectionModel(layoutSettings: layoutSettings)
    }
    
    init(layoutSettings: EULayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
