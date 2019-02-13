//
//  FacebookHelper.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookHelper: NSObject {
    
    static let shared = FacebookHelper()
    var fbLoginManager: FBSDKLoginManager!

    func logInToFacebook(viewController: UIViewController, successWithUserExist: @escaping (_ user : EUUser) -> Void, successWithUserDoesNotExist: @escaping (_ user : EUUser) -> Void,  cancelled : @escaping () -> Void, failure: @escaping (_ error : Error?) -> Void)
    {
        self.fbLoginManager = FBSDKLoginManager()
        self.fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: viewController) { (result : FBSDKLoginManagerLoginResult?, error : Error?) in
            if error != nil {
                failure(error)
            }
            else if result!.isCancelled {
                cancelled()
            }
            else {
                self.getUserProfile(result: result, success: { (userObject) in
                    successWithUserExist(userObject)
                }, failure: { (error) in
                    failure(error)
                })
            }
        }
    }
    
    func getUserProfile(result : FBSDKLoginManagerLoginResult!, success: @escaping (_ userInfo: EUUser) -> Void, failure: @escaping (_ error : Error?) -> Void)
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(normal)"])
        graphRequest.start { (connection : FBSDKGraphRequestConnection?, result : Any?, error :  Error?) in
            if error != nil {
                failure(error)
            }
            else {
                if let dictionary = result as? NSDictionary {
                    let user : EUUser = EUUser()
                    user.userName = dictionary.value(forKeyPath: "name") as! String?

                    if let email = dictionary.value(forKeyPath: "email") as? String, email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count != 0 {
                        user.email = email
                    }
                    user.userId = dictionary.value(forKeyPath: "id") as? String
                    user.userProfileImage = dictionary.value(forKeyPath: "picture.data.url") as? String
                    user.userLoginType = LoginType.FACEBOOK
                    user.userType = UserType.Doctor
                    success(user)
                }
            }
        }
    }
}
