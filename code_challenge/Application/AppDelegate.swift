//
//  AppDelegate.swift
//  code_challenge
//
//  Created by Hien Nguyen on 16/03/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enabledTouchResignedClasses = [RegisterViewController.self]
        return true
    }
}

