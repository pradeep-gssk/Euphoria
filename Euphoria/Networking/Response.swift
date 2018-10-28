//
//  Response.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 10/27/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class Response: NSObject {
    var array: [Parameters] = []
    var dictionary: Parameters = [:]
    
    class func getResponseFromData(_ data: Data?) throws -> Response {
        let response = Response()
        do {
            
            guard let jsonData = data else {
                throw NSError(domain:"Wrong data", code:999, userInfo:nil)
            }
            
            let json = try JSONSerialization.jsonObject(with: jsonData)
            
            if let dictionary = json as? [String: Any] {
                response.dictionary = dictionary
                return response
            }
            else if let array = json as? [[String: Any]] {
                response.array = array
                return response
            }
            else {
                throw NSError(domain:"Wrong data", code:999, userInfo:nil)
            }
        }
        catch {
            throw error
        }
    }
}
