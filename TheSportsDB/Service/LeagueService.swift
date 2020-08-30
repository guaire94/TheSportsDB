//
//  LeagueService.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public protocol LeagueServiceDelegate: class {
    func didSuccessGetLeagues(result: LeagueResult)
    func didFailedGetLeagues()
}

public class LeagueService {
    
    static let shared = LeagueService()
    weak var delegate: LeagueServiceDelegate?

    func getLeagues() {
        LeagueEndpoint.getLeagues() { (success, result) in
            guard success, let result = result else {
                self.delegate?.didFailedGetLeagues()
                return
            }
            self.delegate?.didSuccessGetLeagues(result: result)
        }
    }
}

private class LeagueEndpoint {
    
    public static func getLeagues(completionHandler: @escaping (Bool, LeagueResult?) -> Void) {
        API.call(request: Router.GET(path: API.Method.getLeagues.url()), success: { (leagues) in
            DispatchQueue.main.async {
                completionHandler(true, leagues)
            }
        }) { (statusCode) in
            DispatchQueue.main.async {
                completionHandler(false, nil)
            }
        }
    }
}
