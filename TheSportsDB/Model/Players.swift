//
//  Players.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

public struct PlayerResult: Codable {
    var player: [Player]?
}

public struct Player: Codable {
    var strPlayer: String
    var dateBorn: String
    var strPosition: String
    var strSigning: String
    var strThumb: String?
}
