//
//  APIError.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Foundation

enum APIError: Error {
    case notConnectedToInternet
    case internalServerError
}
