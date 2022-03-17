//
//  TargetType.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Foundation

enum HTTPMethod: String {
    case get, post
}

protocol TargetType {
    // The base URL of request
    var baseURL: URL { get }
    // The method of request
    var method: HTTPMethod { get }
    // The path of request
    var path: String { get }
    // The headers of request
    var headers: [String: String]? { get }
}
