//
//  User.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Foundation

struct User: Decodable {
    var login: String
    var id: Int
    var avatarUrl: URL?
    var url: URL
}
