//
//  EmailValidator.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Foundation

fileprivate let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
fileprivate let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
fileprivate let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
fileprivate let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)


extension String {
    
    func isValidEmail() -> Bool {
        emailPredicate.evaluate(with: self)
    }
}
