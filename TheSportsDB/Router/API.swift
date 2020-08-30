//
//  API.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public typealias SuccessAPIWithData<T> = (_ value: T?) -> Void
public typealias SuccessAPI = () -> Void
public typealias FailureAPI = (_ code: HTTPStatusCode) -> Void

public enum HTTPStatusCode: Int {
    case getSuccess = 200
    case serverError = 500
}

public class API {
    
    enum Method {
        
        case getLeagues
        case search(name:String)

        func url() -> String {
            switch self {
            case .getLeagues:
                return "/all_leagues.php"
            case .search(let name):
                return "/users/search?name=\(name)&limit=10"
            }
        }
    }
    
    public class func call<T:Decodable>(request: Router, success: SuccessAPIWithData<T>?, failure: FailureAPI?) {
        print("URL = \(request.requestURL) (\(request.method))")
        
        let session = URLSession.shared
        session.dataTask(with: request.requestURL){ (data, response, error) -> Void in
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                failure?(HTTPStatusCode.serverError)
                return
            }
            do {
                if (httpResponse.statusCode == HTTPStatusCode.getSuccess.rawValue) {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    success?(value)
                } else {
                    failure?(HTTPStatusCode.serverError)
                }
            }
            catch DecodingError.dataCorrupted(let context) {
                print(context.debugDescription)
                failure?(HTTPStatusCode.serverError)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("\(T.self): \(key.stringValue) was not found, \(context.debugDescription)")
                failure?(HTTPStatusCode.serverError)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("\(T.self): \(type) was expected, \(context.debugDescription)")
                failure?(HTTPStatusCode.serverError)
            } catch DecodingError.valueNotFound(let type, let context) {
                print("\(T.self): no value was found for \(type), \(context.debugDescription)")
                failure?(HTTPStatusCode.serverError)
            } catch let error {
                print(error.localizedDescription)
                failure?(HTTPStatusCode.serverError)
            }
            }.resume()
    }
}
