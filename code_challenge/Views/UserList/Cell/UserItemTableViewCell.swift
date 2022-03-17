//
//  UserItemTableViewCell.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Kingfisher
import UIKit

final class UserItemTableViewCell: UITableViewCell, ObjectIdentifier {
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!

    func configureUser(_ user: User) {
        usernameLabel.text = user.login
        if let avatarUrl = user.avatarUrl {
            avatarImageView.isHidden = false
            avatarImageView.kf.setImage(with: avatarUrl,
                                        options: [
                                            .transition(.fade(0.25))
                                        ])
        } else {
            avatarImageView.isHidden = true
        }
    }
}
