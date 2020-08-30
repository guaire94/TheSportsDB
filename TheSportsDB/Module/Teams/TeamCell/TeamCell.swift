//
//  NearViewCell.swift
//  mooddy
//
//  Created by Quentin Gallois on 4/14/19.
//  Copyright © 2019 Quentin Gallois. All rights reserved.
//

import UIKit
import Kingfisher

class TeamCell: UICollectionViewCell {
    
    // MARK: - Constants
    enum Constants {
        static var identifier = "TeamCell"
    }
    
    // MARK: - IBOutlet
    @IBOutlet private(set) weak var badge: UIImageView!
    @IBOutlet private(set) weak var name: UILabel!
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        badge.image = nil
        name.text = ""
    }
    
    func setUp(team: Team) {
        if let urlBadge = URL(string: team.strTeamBadge) {
            badge.kf.setImage(with: urlBadge)
        }
        name.text = team.strTeam
    }
}

