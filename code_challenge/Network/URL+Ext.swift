//
//  URL+Ext.swift
//  code_challenge
//
//  Created by Hien Nguyen on 18/03/2022.
//

import Foundation

extension URL {
    init(target: TargetType) {
        self = target.baseURL.appendingPathComponent(target.path)
    }
}

extension URLRequest {
    init(url: URL, method: HTTPMethod, headers: [String: String]? = nil) {
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
}
