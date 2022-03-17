//
//  MainCoordinator.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import UIKit

struct MainCoordinator: Coordinator {
    let navigationController: UINavigationController

    func start() {
        let registerVC = RegisterViewController.instantiate()
        registerVC.coordinator = self
        navigationController.setViewControllers([registerVC], animated: false)
    }
}

extension MainCoordinator {

    func openUserList() {
        let userListCoordinator = UserListCoordinator(navigationController: navigationController)
        userListCoordinator.start()
    }
}
