//
//  UserListViewController.swift
//  code_challenge
//
//  Created by Hien Nguyen on 16/03/2022.
//

import UIKit

final class UserListViewController: UIViewController, StoryboardInstaniate, ErrorHandler {
    private let viewModel = UserListViewModel(userDB: UserRepositoryImp())
    var coordinator: UserListCoordinator?

    @IBOutlet private var tableView: UITableView!

    private lazy var loadingView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        updateDataOnView()

        loadingView.startAnimating()
        viewModel.fetchUserList()
    }

    private func configView() {
        // loading view
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Hide separator line when empty
        tableView.tableFooterView = UIView()
        tableView.registerNibCell(type: UserItemTableViewCell.self)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func updateDataOnView() {
        viewModel.updateDataOnView(tableView.items({ tableView, indexPath, user in
            let cell: UserItemTableViewCell = tableView.dequeueCell(for: indexPath)
            cell.configureUser(user)
            return cell
        }, selection: { [weak self] indexPath, user in
            self?.tableView?.deselectRow(at: indexPath, animated: true)
            self?.coordinator?.openUserDetail(user)
        }))

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
        viewModel.fetchUserList()
    }
}

