//
//  UITableView+Ext.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import UIKit

extension UITableView {
    
    func registerNibCell<T: ObjectIdentifier>(type: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: .main), forCellReuseIdentifier: T.identifier)
    }

    func dequeueCell<T: ObjectIdentifier>(for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
