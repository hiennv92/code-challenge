//
//  ErrorHandler.swift
//  code_challenge
//
//  Created by Hien Nguyen on 18/03/2022.
//

import UIKit

protocol ErrorHandler where Self: UIViewController {
    func showAlert(for error: APIError)
}

extension ErrorHandler {

    func showAlert(for error: APIError) {
        let title: String
        let message: String
        switch error {
        case .notConnectedToInternet:
            title = "No internet connection"
            message = "Cannot connect to server. Please try again later!"
        case .internalServerError:
            title = "Internal Server Error"
            message = "There is some error occur. Please try again later!"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
