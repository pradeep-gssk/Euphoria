//
//  EUDietModel.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation
import RxSwift

class EUDietModel: EUViewModel {
    
    let indexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let items = [EUIndexItem(title: "A", items: [EUItem(title: "Alligator", detail: ""),
                                                EUItem(title: "African Bush Elephant", detail: ""),
                                                EUItem(title: "Aardvark", detail: "")]),
                 EUIndexItem(title: "B", items: []),
                 EUIndexItem(title: "C", items: [EUItem(title: "Camel", detail: ""),
                                                EUItem(title: "Cockatoo", detail: "")]),
                 EUIndexItem(title: "D", items: [EUItem(title: "Dog", detail: ""),
                                                EUItem(title: "Donkey", detail: "")]),
                 EUIndexItem(title: "E", items: [EUItem(title: "Emu", detail: "")]),
                 EUIndexItem(title: "F", items: [EUItem(title: "Falcon", detail: ""),
                                                EUItem(title: "Ferret", detail: "")]),
                 EUIndexItem(title: "G", items: [EUItem(title: "Giraffe", detail: ""),
                                                EUItem(title: "Greater Rhea", detail: "")]),
                 EUIndexItem(title: "H", items: [EUItem(title: "Hippopotamus", detail: ""),
                                                EUItem(title: "Horse", detail: "")]),
                 EUIndexItem(title: "I", items: [EUItem(title: "Impala", detail: "")]),
                 EUIndexItem(title: "J", items: [EUItem(title: "Jackal", detail: ""),
                                                EUItem(title: "Jaguar", detail: "")]),
                 EUIndexItem(title: "K", items: [EUItem(title: "Koala", detail: "")]),
                 EUIndexItem(title: "L", items: [EUItem(title: "Lion", detail: ""),
                                                EUItem(title: "Llama", detail: "")]),
                 EUIndexItem(title: "M", items: [EUItem(title: "Manatus", detail: ""),
                                                EUItem(title: "Meerkat", detail: "")]),
                 EUIndexItem(title: "N", items: [EUItem(title: "Numbat", detail: ""),
                                                EUItem(title: "Nyala", detail: "")]),
                 EUIndexItem(title: "O", items: [EUItem(title: "Ocelot", detail: ""),
                                                EUItem(title: "Okapi", detail: "")]),
                 EUIndexItem(title: "P", items: [EUItem(title: "Panda", detail: ""),
                                                EUItem(title: "Peacock", detail: ""),
                                                EUItem(title: "Pig", detail: ""),
                                                EUItem(title: "Platypus", detail: ""),
                                                EUItem(title: "Polar Bear", detail: "")]),
                 EUIndexItem(title: "Q", items: [EUItem(title: "Quokka", detail: ""),
                                                EUItem(title: "Quoll", detail: "")]),
                 EUIndexItem(title: "R", items: [EUItem(title: "Rhinoceros", detail: "")]),
                 EUIndexItem(title: "S", items: [EUItem(title: "Seagull", detail: "")]),
                 EUIndexItem(title: "T", items: [EUItem(title: "Tasmania Devil", detail: "")]),
                 EUIndexItem(title: "U", items: [EUItem(title: "Urial", detail: "")]),
                 EUIndexItem(title: "V", items: [EUItem(title: "Vole", detail: ""),
                                                EUItem(title: "Viper", detail: ""),
                                                EUItem(title: "Vulture", detail: "")]),
                 EUIndexItem(title: "W", items: [EUItem(title: "Whale", detail: ""),
                                                EUItem(title: "Whale Shark", detail: ""),
                                                EUItem(title: "Wombat", detail: "")]),
                 EUIndexItem(title: "X", items: [EUItem(title: "Xenons", detail: "")]),
                 EUIndexItem(title: "Y", items: [EUItem(title: "Yak", detail: "")]),
                 EUIndexItem(title: "Z", items: [EUItem(title: "Zebra", detail: ""),
                                                EUItem(title: "Zebu", detail: "")])]
    
    var layoutSettings: EULayoutSettings
    var selectedListItem: PublishSubject<EUItem?> = PublishSubject()
    
    var navigateToVC: Observable<(navigation: LCFNavigation, viewController: UIViewController)> {
        return self.selectedListItem.unwrap().map({ (item) -> (LCFNavigation, UIViewController) in
            let indexViewModel = self.getIndexesModel(item: item)
            let viewController = UIViewController.getIndexViewController(indexViewModel: indexViewModel, homeType: .Diet)
            return (LCFNavigation.push, viewController)
        })
    }
    
    func getIndexesModel(item: EUItem) -> EUIndexModel {
        let layoutSettings = EUIndexLayoutSettings(titleViewSize: self.layoutSettings.titleViewSize, title: self.layoutSettings.title, titleImage: self.layoutSettings.titleImage, detail: item.detail, homeType: self.layoutSettings.homeType, searchPlaceHolder: "Search", indexes: indexes, items: items)
        return EUIndexModel(layoutSettings: layoutSettings)
    }
    
    init(layoutSettings: EULayoutSettings) {
        self.layoutSettings = layoutSettings
    }
}
