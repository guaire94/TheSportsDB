//
//  TimelineCell.swift
//  Mooddy
//
//  Created by Quentin Gallois on 08/03/2019.
//  Copyright © 2019 Quentin Gallois. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {

    // MARK: - Constants
    enum Constants {
        static var identifier = "LeagueCell"
        static var height: CGFloat = 60.0
    }

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var name: UILabel!
    @IBOutlet private(set) weak var sport: UILabel!
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = ""
        sport.text = ""
    }
    
    func setUp(league: League) {
        name.text = league.strLeague
        sport.text = league.strSport
    }
}
