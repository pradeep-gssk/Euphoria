//
//  Router.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 10/27/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import Foundation

enum Provider {
    case facebook
    case instagram
    
    func getProvider() -> String {
        switch self {
        case .facebook:
            return "Facebook"
        case .instagram:
            return "Instagram"
        }
    }
}

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
}

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

enum Endpoint {
    case Login(email: String, password: String)
    case SocialLogin(type: Provider, token: String)
    case Registration(data: Parameters)
}

class Router: NSObject {
    var endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
        super.init()
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "api/Person"
    }
    
    var parameters: Parameters {
        switch self.endpoint {
        case .Registration(let data):
                return data
        default:
            return [:]
        }
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var fullPath: String {
        return "\(baseUrl)\(self.path)"
    }
}
