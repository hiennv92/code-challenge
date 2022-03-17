//
//  UserListCoordinator.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import UIKit

struct UserListCoordinator: Coordinator {
    let navigationController: UINavigationController

    func start() {
        let userListVC = UserListViewController.instantiate()
        userListVC.coordinator = self
        navigationController.pushViewController(userListVC, animated: true)
    }
}

extension UserListCoordinator {
    func openUserDetail(_ user: User) {
        let userDetailVC = UserDetailViewController.instantiate()
        userDetailVC.user = user
        navigationController.pushViewController(userDetailVC, animated: true)
    }
}
