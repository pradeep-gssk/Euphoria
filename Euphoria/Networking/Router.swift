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
typealias HTTPBody = Data
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
        switch self.endpoint {
        case .Login(_, _):
            return .get
        default:
            return .post
        }
        
    }
    
    var path: String {
        switch self.endpoint {
        case .Login(let email, let password):
            return "api/person/Login?user=\(email)&password=\(password)"
        case .Registration(_):
            return "api/Person"
        default:
            return "api/Person"
        }
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
        return ["Authorization": "Basic Y2tjOjEyMzQ=", "Content-Type": "application/json"]
    }
    
    var fullPath: String {
        return "\(baseUrl)\(self.path)"
    }
    
    func httpBody() throws -> HTTPBody {
        switch self.endpoint {
        case .Registration(let data):
            do {
                let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                return data
            } catch {
                throw NSError(domain:"Wrong parameters", code:999, userInfo:nil)
            }
        default:
            let parameters = self.parameters.map { "\($0)=\($1)" }.joined(separator: "&")
            guard let data = parameters.data(using: .utf8, allowLossyConversion: false)  else {
                throw NSError(domain:"Wrong parameters", code:999, userInfo:nil)
            }
            return data
        }
    }
}
