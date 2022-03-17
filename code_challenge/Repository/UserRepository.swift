//
//  UserRepository.swift
//  code_challenge
//
//  Created by Hien Nguyen on 18/03/2022.
//

import Combine
import Foundation

protocol UserRepository {
    func fetchUserList() -> AnyPublisher<[User], APIError>
    func fetchUserDetail(userUrl: URL) -> AnyPublisher<UserDetail, APIError>
}

struct UserRepositoryImp: UserRepository {
    private var client = ApiClient()

    func fetchUserList() -> AnyPublisher<[User], APIError> {
        client.request(.users)
    }

    func fetchUserDetail(userUrl: URL) -> AnyPublisher<UserDetail, APIError> {
        client.request(.custom(url: userUrl))
    }
}
