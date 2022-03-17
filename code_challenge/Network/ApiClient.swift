//
//  ApiClient.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Combine
import Foundation

private var jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

struct ApiClient {

    func request<T: Decodable>(_ path: RoutePath) -> AnyPublisher<T, APIError> {
        URLSession.shared
            .dataTaskPublisher(for: path.asURLRequest())
            .tryMap { data, _ in
                try jsonDecoder.decode(T.self, from: data)
            }.mapError { error in
                if (error as? URLError)?.code == .notConnectedToInternet {
                    return APIError.notConnectedToInternet
                }
                return APIError.internalServerError
            }.eraseToAnyPublisher()
    }
}
