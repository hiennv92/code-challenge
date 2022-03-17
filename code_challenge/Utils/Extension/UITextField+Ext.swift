//
//  UITextField+Ext.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import Combine
import UIKit

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }.compactMap{ $0 }
            .eraseToAnyPublisher()
    }
}

