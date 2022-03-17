//
//  UserListViewModel.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Combine
import Foundation

final class UserListViewModel {
    private let userDB: UserRepository
    var disposables = Set<AnyCancellable>()

    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var error: APIError?

    init(userDB: UserRepository) {
        self.userDB = userDB
    }

    func fetchUserList() {
        isLoading = true
        userDB.fetchUserList()
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                if case .failure(let error) = result {
                    self?.error = error
                }
                self?.isLoading = false
            } receiveValue: { [weak self] users in
                self?.users = users
            }.store(in: &disposables)

    }

    func updateDataOnView(_ builder: @escaping ([User]) -> Void) {
        $users.sink(receiveValue: builder)
            .store(in: &disposables)
    }
}
