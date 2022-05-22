//
//  RefreshControl.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

import UIKit

enum PullToRefreshState {
    case readyToRefresh
    case refreshing
    case doneRefreshing
}

final class RefreshControl: UIRefreshControl {
    
    var closurePullToRefreshDidComplete: (() -> Void)?
    
    private let pullToRefreshText = "Pull to refresh"
    
    private let refreshingText = "Refreshing..."
    
    private let doneText = "Done."
    
    override init() {
        super.init()
        setState(.readyToRefresh)
        addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func pullToRefreshAction() {
        closurePullToRefreshDidComplete?()
    }
    
    func setState(_ pullToRefreshState: PullToRefreshState) {
        switch pullToRefreshState {
        case .readyToRefresh:
            attributedTitle = NSAttributedString(string: pullToRefreshText)
        case .refreshing:
            attributedTitle = NSAttributedString(string: refreshingText)
        case .doneRefreshing:
            attributedTitle = NSAttributedString(string: doneText)
            endRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.setState(.readyToRefresh)
            }
        }
    }
}
