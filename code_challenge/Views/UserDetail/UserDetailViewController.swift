//
//  UserDetailViewController.swift
//  code_challenge
//
//  Created by Hien Nguyen on 16/03/2022.
//

import UIKit

final class UserDetailViewController: UIViewController, StoryboardInstaniate, ErrorHandler {

    @IBOutlet private var tableView: UITableView!

    private let viewModel = UserDetailViewModel(userDB: UserRepositoryImp())

    private lazy var loadingView = UIActivityIndicatorView(style: .large)

    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        updateDataOnView()

        loadingView.startAnimating()
        viewModel.fetchUserDetail(url: user.url)
    }

    private func configureView() {
        // loading view
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tableView.tableFooterView = UIView()
        tableView.registerNibCell(type: UserInfoTableViewCell.self)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func updateDataOnView() {
        viewModel.$itemList
            .sink(receiveValue: tableView.items { tableView, indexPath, item in
                let cell: UserInfoTableViewCell = tableView.dequeueCell(for: indexPath)
                cell.configureUserInfo(item)
                return cell
            }).store(in: &viewModel.disposables)

        viewModel.$isLoading
            .dropFirst()
            .filter { !$0 }
            .sink { [weak self] _ in
                self?.loadingView.isHidden = true
                self?.tableView.refreshControl?.endRefreshing()
            }.store(in: &viewModel.disposables)

        viewModel.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.showAlert(for: error)
            }.store(in: &viewModel.disposables)
    }

    @objc
    private func onRefreshData() {
        viewModel.fetchUserDetail(url: user.url)
    }
}
