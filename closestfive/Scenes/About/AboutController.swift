//
//  AboutController.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 27.05.2022.
//

import UIKit
import WebKit

final class AboutController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        if let url = URL(string: "https://www.asanli.dev/") {
            webView.load(URLRequest(url: url))
        }
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
