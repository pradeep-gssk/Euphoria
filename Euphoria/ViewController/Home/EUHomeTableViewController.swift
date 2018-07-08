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
            let model = self.getSettingsModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
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
    
    func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    func getListViewController(model: EUViewModel) -> EUListViewController {
        let viewController = self.getViewController(storyboard: "Main", identifier: "ListViewController") as! EUListViewController
        viewController.model = model
        return viewController
    }
    
    func getQuestionnairesModel() -> EUViewModel {
        let questionnaires: [EUItem] = [EUItem(title: "Q1", detail: "Questionnaire 1"), EUItem(title: "Q2", detail: "Questionnaire 2"), EUItem(title: "Q3", detail: "Questionnaire 3"), EUItem(title: "Q4", detail: "Questionnaire 4"), EUItem(title: "Q5", detail: "Questionnaire 5")]

        let titleImage = UIImage(named: "titleBlue")?.stretch()
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBlue"), rectImage: UIImage(named: "rectangleBlue"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 145, height: 25), title: "QUESTIONNAIRES", titleImage: titleImage, detail: nil, cellLayout: cellLayout, homeType: .Questionnaires, items: questionnaires)
        return EUListModel(layoutSettings: layoutSettings)
    }
    
    func getDietModel() -> EUViewModel {
        let diets: [EUItem] = [EUItem(title: "F", detail: "Fruits"), EUItem(title: "V", detail: "Vegetables"), EUItem(title: "C", detail: "Cereals"), EUItem(title: "M", detail: "Meat"), EUItem(title: "F", detail: "Fish")]

        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalGreen"), rectImage: UIImage(named: "rectangleGreen"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: "DIET", titleImage: UIImage(named: "titleGreen"), detail: nil, cellLayout: cellLayout, homeType: .Diet, items: diets)
        return EUListModel(layoutSettings: layoutSettings)
    }
    
    func getExercisesModel() -> EUViewModel {
        let exercises: [EUItem] = [EUItem(title: "Y", detail: "Yoga"), EUItem(title: "P", detail: "Pilates"), EUItem(title: "R", detail: "Running"), EUItem(title: "C", detail: "Climbing"), EUItem(title: "Q", detail: "Qi Gong"), EUItem(title: "S", detail: "Stretching")]
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalRed"), rectImage: UIImage(named: "rectangleRed"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: "EXERCISES", titleImage: UIImage(named: "titleRed"), detail: nil, cellLayout: cellLayout, homeType: .Exercises, items: exercises)
        return EUListModel(layoutSettings: layoutSettings)
    }
    
    func getActivitiesModel() -> EUViewModel {
        let activities: [EUItem] = [EUItem(title: "C", detail: "my Calendar")]
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBrown"), rectImage: UIImage(named: "rectangleBrown"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: "ACTIVITIES", titleImage: UIImage(named: "titleBrown"), detail: nil, cellLayout: cellLayout, homeType: .Activities, items: activities)
        return EUListModel(layoutSettings: layoutSettings)
    }
    
    func getHistoryModel() -> EUViewModel {
        let history: [EUItem] = [EUItem(title: "F", detail: "my Face"), EUItem(title: "T", detail: "my Tongue")]
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBlue"), rectImage: UIImage(named: "rectangleBlue"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: "HISTORY", titleImage: UIImage(named: "titleBlue"), detail: nil, cellLayout: cellLayout, homeType: .History, items: history)
        return EUListModel(layoutSettings: layoutSettings)
    }
    
    func getGalleryModel() -> EUViewModel {
        let diets: [EUItem] = [EUItem(title: "V", detail: "Videos"), EUItem(title: "O", detail: "Other")]
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalGreen"), rectImage: UIImage(named: "rectangleGreen"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: "GALLERY", titleImage: UIImage(named: "titleGreen"), detail: nil, cellLayout: cellLayout, homeType: .Gallery, items: diets)
        return EUListModel(layoutSettings: layoutSettings)
    }
    
    func getSettingsModel() -> EUViewModel {
        let history: [EUItem] = [EUItem(title: "A", detail: "my Account"), EUItem(title: "S", detail: "Sign in options"), EUItem(title: "S", detail: "Sync your settings")]
        
        let cellLayout = EUCellLayoutSettings(ovalImage: UIImage(named: "ovalBlue"), rectImage: UIImage(named: "rectangleBlue"))
        let layoutSettings = EULayoutSettings(titleViewSize: CGSize(width: 93, height: 25), title: "SETTINGS", titleImage: UIImage(named: "titleBlue"), detail: nil, cellLayout: cellLayout, homeType: .Settings, items: history)
        return EUListModel(layoutSettings: layoutSettings)
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch HomeType(rawValue: indexPath.row) {
        case .Questionnaires?:
            let model = self.getQuestionnairesModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
            
        case .Diet?:
            let model = self.getDietModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
            
        case .Exercises?:
            let model = self.getExercisesModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
            
        case .Activities?:
            let model = self.getActivitiesModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
            
        case .History?:
            let model = self.getHistoryModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
            
        case .Gallery?:
            let model = self.getGalleryModel()
            let viewController = self.getListViewController(model: model)
            self.navigationController?.show(viewController, sender: model)
            
        default:
            break
        }
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) { }
}


