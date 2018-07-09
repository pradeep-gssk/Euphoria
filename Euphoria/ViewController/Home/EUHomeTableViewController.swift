//
//  EUHomeTableViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/24/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUHomeTableViewController: UITableViewController {

    @IBOutlet weak var settingsButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()

        self.settingsButton.rx.tap.bind(onNext: {
            let viewModel = self.getSettingsModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
        }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            self.navigationController?.toolbar.barTintColor = UIColor(named: "navBarColor")
        } else {
            self.navigationController?.toolbar.barTintColor = UIColor(red: (243.0/255.0), green: (239.0/255.0), blue: (234.0/255.0), alpha: 1.0)
        }
    }
    
    func getQuestionnairesModel() -> EUViewModel {
        let questionnaires = HomeType.Questionnaires.items
        let titleImage = UIImage(named: "titleBlue")?.stretch()
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBlue"), rectImage: UIImage(named: "rectangleBlue"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 145, height: 25), title: HomeType.Questionnaires.title, titleImage: titleImage, detail: nil, cellLayout: cellLayout, homeType: .Questionnaires, items: questionnaires)
        return EUQuestionnairesModel(layoutSettings: layoutSettings)
    }
    
    func getDietModel() -> EUViewModel {
        let diets = HomeType.Diet.items
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalGreen"), rectImage: UIImage(named: "rectangleGreen"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: HomeType.Diet.title, titleImage: UIImage(named: "titleGreen"), detail: nil, cellLayout: cellLayout, homeType: .Diet, items: diets)
        return EUDietModel(layoutSettings: layoutSettings)
    }
    
    func getExercisesModel() -> EUViewModel {
        let exercises = HomeType.Exercises.items
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalRed"), rectImage: UIImage(named: "rectangleRed"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: HomeType.Exercises.title, titleImage: UIImage(named: "titleRed"), detail: nil, cellLayout: cellLayout, homeType: .Exercises, items: exercises)
        return EUExercisesModel(layoutSettings: layoutSettings)
    }
    
    func getActivitiesModel() -> EUViewModel {
        let activities = HomeType.Activities.items
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBrown"), rectImage: UIImage(named: "rectangleBrown"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: HomeType.Activities.title, titleImage: UIImage(named: "titleBrown"), detail: nil, cellLayout: cellLayout, homeType: .Activities, items: activities)
        return EUActivitiesModel(layoutSettings: layoutSettings)
    }
    
    func getHistoryModel() -> EUViewModel {
        let history = HomeType.History.items
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBlue"), rectImage: UIImage(named: "rectangleBlue"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: HomeType.History.title, titleImage: UIImage(named: "titleBlue"), detail: nil, cellLayout: cellLayout, homeType: .History, items: history)
        return EUHistoryModel(layoutSettings: layoutSettings)
    }
    
    func getGalleryModel() -> EUViewModel {
        let diets = HomeType.Gallery.items
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalGreen"), rectImage: UIImage(named: "rectangleGreen"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: HomeType.Gallery.title, titleImage: UIImage(named: "titleGreen"), detail: nil, cellLayout: cellLayout, homeType: .Gallery, items: diets)
        return EUGalleryModel(layoutSettings: layoutSettings)
    }
    
    func getSettingsModel() -> EUViewModel {
        let settings = HomeType.Settings.items
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBlue"), rectImage: UIImage(named: "rectangleBlue"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: HomeType.Settings.title, titleImage: UIImage(named: "titleBlue"), detail: nil, cellLayout: cellLayout, homeType: .Settings, items: settings)
        return EUSettingsModel(layoutSettings: layoutSettings)
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch HomeType(rawValue: indexPath.row) {
        case .Questionnaires?:
            let viewModel = self.getQuestionnairesModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
            
        case .Diet?:
            let viewModel = self.getDietModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
            
        case .Exercises?:
            let viewModel = self.getExercisesModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
            
        case .Activities?:
            let viewModel = self.getActivitiesModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
            
        case .History?:
            let viewModel = self.getHistoryModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
            
        case .Gallery?:
            let viewModel = self.getGalleryModel()
            let viewController = UIViewController.getListViewController(viewModel: viewModel)
            self.navigationController?.show(viewController, sender: viewModel)
            
        default:
            break
        }
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        self.navigationController?.isToolbarHidden = false
    }
}


