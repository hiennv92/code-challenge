//
//  AppCoordinator.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import UIKit

struct AppCoordinator: Coordinator {
    let window: UIWindow

    func start() {
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
