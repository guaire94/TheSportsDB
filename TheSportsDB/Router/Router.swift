//
//  Router.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

// MARK: Router
public enum Router {
    
    // api calls
    case GET(path: String)

    // api methods
    var method : String {
        switch self {
        case .GET:
            return "GET"
        }
    }
    
    // api paths
    var path: String {
        switch self {
        case .GET(path: let path):
            return path
        }
    }
    
    // api url request
    public var requestURL: URLRequest {
        let trimmedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: baseURLString + apiKey + trimmedPath)!
        switch self {
        case .GET(path: _):
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.setValue(NSLocale.current.identifier , forHTTPHeaderField: "Accept-Language")
            return request
        }
    }
}


