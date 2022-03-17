//
//  RoutePath.swift
//  code_challenge
//
//  Created by Hien Nguyen on 18/03/2022.
//

import Foundation

enum RoutePath {
    case users
    case custom(url: URL)
}

extension RoutePath: TargetType {
    var baseURL: URL {
        URL(string: "https://api.github.com/")!
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "users"
    }

    var headers: [String : String]? {
        nil
    }

    func asURLRequest() -> URLRequest {
        let url: URL
        if case .custom(let customUrl) = self {
            url = customUrl
        } else {
            url = URL(target: self)
        }

        let urlRequest = URLRequest(url: url, method: method, headers: headers)
        return urlRequest
    }
}
