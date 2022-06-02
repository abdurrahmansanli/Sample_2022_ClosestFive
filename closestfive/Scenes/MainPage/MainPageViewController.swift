//
//  MainPageViewController.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 27.05.2022.
//

import UIKit

struct MainPageSegment {
    let title: String
    let controller: UIViewController
}

final class MainPageViewController: UIViewController {
    
    let segments: [MainPageSegment] = [MainPageSegment(title: "Venues", controller: VenuesViewController()),
                                       MainPageSegment(title: "About", controller: AboutController())]
    
    private let viewModel = MainPageViewModel()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: segments.map { $0.title})
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        showController(segments[0].controller)
    }
    
    private func layout() {
        view.backgroundColor = .white
        
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        segments.forEach { segment in
            if let segmentControllerView = segment.controller.view {
                view.addSubview(segmentControllerView)
                segmentControllerView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    segmentControllerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                    segmentControllerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    segmentControllerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    segmentControllerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
            }
        }
    }
    
    @objc
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        showController(segments[sender.selectedSegmentIndex].controller)
    }
    
    private func showController(_ controllerToShow: UIViewController) {
        segments.forEach { segment in
            let segmentController = segment.controller
            if segmentController == controllerToShow {
                segmentController.view.isHidden = false
            } else {
                segmentController.view.isHidden = true
            }
        }
    }
}
