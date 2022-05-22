//
//  MainPageViewController.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import UIKit

final class MainPageViewController: UIViewController {
    
    private let viewModel = MainPageViewModel()
    
    private lazy var refreshControl: RefreshControl = {
        let refreshControl = RefreshControl()
        refreshControl.closurePullToRefreshDidComplete = pullToRefreshAction
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(refreshControl)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        viewModel.refreshPlaces()
    }
    
    private func layout() {
        title = "Closest 5"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.closurePlacesWillUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.setState(.refreshing)
            }
        }
        
        viewModel.closurePlacesDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.setState(.doneRefreshing)
            }
        }
    }
    
    @objc
    private func pullToRefreshAction() {
        viewModel.refreshPlaces()
    }
}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = viewModel.places[indexPath.row]
        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.text = place.name
        return tableViewCell
    }
}

extension MainPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
