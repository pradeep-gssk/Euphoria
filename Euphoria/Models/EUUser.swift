//
//  EUUser.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUUser: NSObject, NSCoding {
    var userName: String?
    var email: String?
    var userId: String?
    var userProfileImage: String?
    var userLoginType: LoginType?
    var userType : UserType?
    
    static let shared = EUUser.getUser()
    
    class func getUser() -> EUUser {
        if let  archivedObject = UserDefaults.standard.object(forKey:USER_PROFILE_DATA){
            if let user  = NSKeyedUnarchiver.unarchiveObject(with: (archivedObject as! NSData) as Data) as? EUUser {
                return user;
            }
        }
        
        return EUUser()
    }
    
    override init() {
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(data, forKey: USER_PROFILE_DATA)
        UserDefaults.standard.synchronize()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.email, forKey: "accessToken")
        aCoder.encode(self.userId, forKey: "userId")
        aCoder.encode(self.userProfileImage, forKey: "userProfileImage")
        aCoder.encode(self.userLoginType!.rawValue, forKey: "userLoginType")
        aCoder.encode(self.userType!.rawValue, forKey: "userType")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userName = aDecoder.decodeObject(forKey: "userName") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.userProfileImage = aDecoder.decodeObject(forKey: "userProfileImage") as? String
        if let string = aDecoder.decodeObject(forKey: "userLoginType") as? String
        {
            self.userLoginType = LoginType(rawValue: string)
        }
        
        if let string = aDecoder.decodeObject(forKey: "userType") as? String
        {
            self.userType = UserType(rawValue: string)
        }
    }

}
