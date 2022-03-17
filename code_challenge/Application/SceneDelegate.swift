//
//  SceneDelegate.swift
//  code_challenge
//
//  Created by Hien Nguyen on 16/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Attach new window immediately will cause the Unbalance transition.
        // So start the app coordinator in the async method
        window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
    }

}

