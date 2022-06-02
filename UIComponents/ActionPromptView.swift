//
//  ActionPrompt.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 27.05.2022.
//

import UIKit

final class ActionPromptView: UIView {
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        return button
    }()
    
    private let closureButtonAction: (() -> Void)
    
    init(message: String, buttonTitle: String, closureButtonAction: @escaping () -> Void) {
        self.closureButtonAction = closureButtonAction
        super.init(frame: .zero)
        messageLabel.text = message
        mainButton.setTitle(buttonTitle, for: .normal)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func layout() {
        backgroundColor = .lightGray
        
        mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            messageLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 50),
            messageLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -50),
            messageLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addSubview(mainButton)
        NSLayoutConstraint.activate([
            mainButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 50),
            mainButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -50),
            mainButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            mainButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
        ])
    }
    
    @objc
    private func mainButtonAction() {
        closureButtonAction()
    }
}
