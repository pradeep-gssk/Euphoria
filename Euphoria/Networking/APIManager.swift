//
//  APIManager.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 10/27/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

class APIManager: NSObject {
    static let shared = APIManager()
    
    func requestUser(router: Router, success: @escaping (_ user: EUUser) -> Void, failure: @escaping (_ error: Error) -> Void) {
        do {
            let request = try URLRequest(router: router)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    failure(error!)
                }
                else {
                    if let data = data,
                        let userObject = try? JSONDecoder().decode(EUUser.self, from: data) {
                        userObject.save()
                        success(userObject)
                    }
                    else {
                        failure(NSError(domain:"Wrong data", code:999, userInfo:nil))
                    }
                }
            }.resume()
        }
        catch {
            failure(error)
        }
    }
    
    func requestJSON(router: Router, success: @escaping (_ response: Response) -> Void, failure: @escaping (_ error: Error) -> Void) {
        do {
            let request = try URLRequest(router: router)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    failure(error!)
                }
                else {
                    do {
                        let response = try Response.getResponseFromData(data)
                        success(response)
                    }
                    catch {
                        failure(error)
                    }
                }
                }.resume()
        }
        catch {
            failure(error)
        }
    }
}
