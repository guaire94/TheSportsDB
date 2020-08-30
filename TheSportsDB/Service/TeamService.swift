//
//  TeamService.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public protocol TeamServiceDelegate: class {
    func didSuccessGetTeams(result: TeamResult)
    func didFailedGetTeams()
}

public class TeamService {
    
    static let shared = TeamService()
    weak var delegate: TeamServiceDelegate?

    func getTeams(idLeague: String) {
        TeamEndpoint.getTeams(idLeague: idLeague) { [weak self] (success, result) in
            guard success, let result = result else {
                self?.delegate?.didFailedGetTeams()
                return
            }
            self?.delegate?.didSuccessGetTeams(result: result)
        }
    }
}

private class TeamEndpoint {
    
    public static func getTeams(idLeague: String, completionHandler: @escaping (Bool, TeamResult?) -> Void) {
        API.call(request: Router.GET(path: API.Method.getTeams(idLeague: idLeague).url()), success: { (result) in
            DispatchQueue.main.async {
                completionHandler(true, result)
            }
        }) { (statusCode) in
            DispatchQueue.main.async {
                completionHandler(false, nil)
            }
        }
    }
}
