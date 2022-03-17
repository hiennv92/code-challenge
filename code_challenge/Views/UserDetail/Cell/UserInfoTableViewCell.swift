//
//  UserInfoTableViewCell.swift
//  code_challenge
//
//  Created by Hien Nguyen on 18/03/2022.
//

import UIKit

final class UserInfoTableViewCell: UITableViewCell, ObjectIdentifier {

    func configureUserInfo(_ item: UserInfoItem) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.content
    }
}
