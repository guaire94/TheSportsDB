//
//  League.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public struct LeagueResult: Codable {
    var leagues: [League]
}

public struct League: Codable {
    var idLeague: String
    var strLeague: String
    var strSport: String
}
