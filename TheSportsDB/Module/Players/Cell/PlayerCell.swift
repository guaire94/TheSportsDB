//
//  TimelineCell.swift
//  Mooddy
//
//  Created by Quentin Gallois on 08/03/2019.
//  Copyright © 2019 Quentin Gallois. All rights reserved.
//

import UIKit
import Kingfisher

class PlayerCell: UITableViewCell {

    // MARK: - Constants
    enum Constants {
        static var identifier = "PlayerCell"
        static var height: CGFloat = 142.0
    }

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var avatar: UIImageView!
    @IBOutlet private(set) weak var name: UILabel!
    @IBOutlet private(set) weak var position: UILabel!
    @IBOutlet private(set) weak var birthDate: UILabel!
    @IBOutlet private(set) weak var price: UILabel!
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.image = nil
        name.text = ""
        position.text = ""
        birthDate.text = ""
        price.text = ""
    }
    
    func setUp(player: Player) {
        setUpDesign()
        if let thumb = player.strThumb, let urlAvatar = URL(string: thumb) {
            avatar.kf.setImage(with: urlAvatar)
        } else {
            avatar.image = #imageLiteral(resourceName: "playerPlaceHolder")
        }
        name.text = player.strPlayer
        position.text = player.strPosition
        birthDate.text = player.dateBorn
        price.isHidden = player.strSigning.isEmpty
        price.text = player.strSigning
    }
    
    private func setUpDesign() {
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.clipsToBounds = true
    }
}
