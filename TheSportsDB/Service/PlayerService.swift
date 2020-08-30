//
//  PlayerService.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public protocol PlayerServiceDelegate: class {
    func didSuccessGetPlayers(result: PlayerResult)
    func didFailedGetPlayers()
}

public class PlayerService {
    
    static let shared = PlayerService()
    weak var delegate: PlayerServiceDelegate?

    func getPlayers(idTeam: String) {
        PlayerEndpoint.getPlayers(idTeam: idTeam) { [weak self] (success, result) in
            guard success, let result = result else {
                self?.delegate?.didFailedGetPlayers()
                return
            }
            self?.delegate?.didSuccessGetPlayers(result: result)
        }
    }
}

private class PlayerEndpoint {
    
    public static func getPlayers(idTeam: String, completionHandler: @escaping (Bool, PlayerResult?) -> Void) {
        API.call(request: Router.GET(path: API.Method.getPlayers(idTeam: idTeam).url()), success: { (result) in
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
