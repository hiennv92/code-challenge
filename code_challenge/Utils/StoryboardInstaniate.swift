//
//  ViewController+Ext.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import UIKit

protocol ObjectIdentifier {
    static var identifier: String { get }
}

extension ObjectIdentifier {
    /// Implement default UIViewController's identifiier  using its name type
    static var identifier: String {
        String(describing: Self.self)
    }
}

protocol StoryboardInstaniate: ObjectIdentifier where Self: UIViewController {

    static func instantiate(from storyboard: UIStoryboard) -> Self
}

extension StoryboardInstaniate {
    static func instantiate(from storyboard: UIStoryboard = .main) -> Self  {
        storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
