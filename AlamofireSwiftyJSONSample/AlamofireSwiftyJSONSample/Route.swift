//
//  Route.swift
//  AlamofireSwiftyJSONSample
//
//  Created by huan huan on 11/17/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case login(parameters: Parameters)
    case createUser(parameters: Parameters)
    
    static let baseURLString = "http://api-dev.sab247.com"
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .createUser:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/v2/account/login"
        case .createUser:
            return "/v2/account/create"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .login(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .createUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
