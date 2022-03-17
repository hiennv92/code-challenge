//
//  UserDetailViewModel.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Combine
import Foundation

final class UserDetailViewModel {
    private let userDB: UserRepository
    var disposables = Set<AnyCancellable>()

    @Published var itemList: [UserInfoItem] = []
    @Published var isLoading = false
    @Published var error: APIError?

    init(userDB: UserRepository) {
        self.userDB = userDB
    }

    func fetchUserDetail(url: URL) {
        isLoading = true
        userDB.fetchUserDetail(userUrl: url)
            .receive(on: RunLoop.main)
            .map {
                [UserInfoItem(title: "Name:", content: $0.name),
                 UserInfoItem(title: "Company:", content: $0.company),
                 UserInfoItem(title: "Location:", content: $0.location),
                 UserInfoItem(title: "Blog:", content: $0.blog)
                ].filter { $0.content != nil }
            }
            .sink { [weak self] result in
                if case .failure(let error) = result {
                    self?.error = error
                }
                self?.isLoading = false
            } receiveValue: { [weak self] itemList in
                self?.itemList = itemList
            }.store(in: &disposables)

    }
}
