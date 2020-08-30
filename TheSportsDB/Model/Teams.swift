//
//  Teams.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public struct TeamResult: Codable {
    var teams: [Team]
}

public struct Team: Codable {
    var idTeam: String
    var strTeam: String
    var strTeamBadge: String
}
