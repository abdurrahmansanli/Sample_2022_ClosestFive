//
//  VenuesViewController.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import UIKit

final class VenuesViewController: UIViewController {
    
    private let viewModel = VenuesViewModel()
    
    private lazy var refreshControl: RefreshControl = {
        let refreshControl = RefreshControl()
        refreshControl.closurePullToRefreshDidComplete = pullToRefreshAction
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var actionPromptView: ActionPromptView = {
        let message = "You need location permission to use Closest 5"
        let buttonTitle = "App Settings"
        let actionPromptView = ActionPromptView(message: message,
                                                buttonTitle: buttonTitle,
                                                closureButtonAction: goToAppSettings)
        actionPromptView.translatesAutoresizingMaskIntoConstraints = false
        actionPromptView.isHidden = true
        return actionPromptView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        viewModel.refresh()
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
        
        view.addSubview(actionPromptView)
        NSLayoutConstraint.activate([
            actionPromptView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            actionPromptView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            actionPromptView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private func bind() {
        viewModel.closurePlacesWillUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if self.viewModel.places.count == 0 {
                    let offsetPoint = CGPoint.init(x: 0, y: -self.view.bounds.size.height)
                    self.tableView.setContentOffset(offsetPoint, animated: false)
                }
                self.refreshControl.setState(.refreshing)
            }
        }
        
        viewModel.closurePlacesDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.setContentOffset(.zero, animated: false)
                self?.tableView.reloadData()
                self?.refreshControl.setState(.doneRefreshing)
            }
        }
        
        viewModel.closureLocationPermissionStateDidUpdate = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .locationPermissionNotDetermined:
                    self?.actionPromptView.isHidden = true
                    self?.tableView.isHidden = false
                case .locationPermissionGiven:
                    self?.actionPromptView.isHidden = true
                    self?.tableView.isHidden = false
                case .locationPermissionNotGiven:
                    self?.actionPromptView.isHidden = false
                    self?.tableView.isHidden = true
                }
            }
        }
    }
    
    @objc
    private func pullToRefreshAction() {
        viewModel.refresh()
    }
    
    @objc
    private func goToAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
}

extension VenuesViewController: UITableViewDataSource {
    
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

extension VenuesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
