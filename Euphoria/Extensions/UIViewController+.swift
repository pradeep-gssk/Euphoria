//
//  UIViewController+.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

extension UIViewController {
    
    func gotoHome() {
        self.performSegue(withIdentifier: "GoToHome", sender: self)
    }
    
    static func getViewController(name: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    static func getQuestionnaireViewController() -> EUQuestionnaireIndexTableViewController {
        let viewController = self.getViewController(name: "Questionnaires", identifier: "QuestionnaireListView") as! EUQuestionnaireIndexTableViewController
        return viewController
    }
}
