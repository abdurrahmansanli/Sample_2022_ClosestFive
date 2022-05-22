//
//  MainPageViewController.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import UIKit

final class MainPageViewController: UIViewController {

    let viewModel = MainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        viewModel.getPlaces()
    }
    
    private func layout() {
        view.backgroundColor = .green
    }
}
