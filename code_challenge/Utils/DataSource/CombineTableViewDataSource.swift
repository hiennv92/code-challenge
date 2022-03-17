//
//  CombineTableViewDataSource.swift
//  code_challenge
//
//  Created by Hien Nguyen on 17/03/2022.
//

import UIKit

extension UITableView {
    func items<Element>(_ builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell, selection: ((IndexPath, Element) -> Void)? = nil) -> ([Element]) -> Void {
        let dataSource = CombineTableViewDataSource(builder: builder, selection: selection)
        return { items in
            dataSource.pushElements(items, to: self)
        }
    }
}

final class CombineTableViewDataSource<Element>: NSObject, UITableViewDataSource, UITableViewDelegate {

    let build: (UITableView, IndexPath, Element) -> UITableViewCell
    let selection: ((IndexPath, Element) -> Void)?
    var elements: [Element] = []

    init(builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell, selection: ((IndexPath, Element) -> Void)?) {
        build = builder
        self.selection = selection
        super.init()
    }

    func pushElements(_ elements: [Element], to tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        self.elements = elements
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        build(tableView, indexPath, elements[indexPath.row])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(indexPath, elements[indexPath.row])
    }
}
