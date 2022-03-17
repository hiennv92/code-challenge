//
//  RegisterViewController.swift
//  code_challenge
//
//  Created by Hien Nguyen on 16/03/2022.
//

import Combine
import UIKit

final class RegisterViewController: UIViewController, StoryboardInstaniate {
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var confirmEmalTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var textFieldList: [UITextField]!

    var coordinator: MainCoordinator?

    private let viewModel = RegisterViewModel()
    private var disposables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        handleRegisterButtonStatus()
    }

    private func configureViews() {
        // Default disable Register button
        registerButton.isEnabled = false
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 25

        // Change background color
        registerButton.publisher(for: \.isEnabled)
            .sink { [weak self] isEnabled in
                self?.registerButton.backgroundColor = isEnabled ? .blue : .lightGray
            }.store(in: &disposables)
    }

    private func handleRegisterButtonStatus() {
        let isNameValid = nameTextField.textPublisher.map { $0.isEmpty == false }
        let isEmailValid = Publishers.CombineLatest(emailTextField.textPublisher,
                                                    confirmEmalTextField.textPublisher)
            .map { email, confirmEmail in
                email?.isValidEmail() == true && email == confirmEmail
            }
        let isPasswordValid = Publishers.CombineLatest(passwordTextField.textPublisher,
                                                       confirmPasswordTextField.textPublisher)
            .map {
                $0?.isEmpty == false && $0 == $1
            }

        Publishers.CombineLatest3(isNameValid, isEmailValid, isPasswordValid)
            .map { $0 && $1 && $2 }
            .assign(to: \.isEnabled, on: registerButton)
            .store(in: &disposables)
    }

    @IBAction private func registerButtonPressed() {
        coordinator?.openUserList()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFieldList.firstIndex(of: textField) else {
            return true
        }
        if index < textFieldList.count - 1 {
            textFieldList[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}
