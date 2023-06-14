//
//  MainView.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 16.03.2023.
//

import UIKit


class MainView: UIView {
    
    var userName: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: MUserDefaults.username.localizedCapitalized,
            attributes: [:]
        )
        label.textAlignment = .left
        return label
    }()
    
    var avatarView: AvatarView = AvatarView()
    
    var headerHStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    var cameraButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(
            UIImage(systemName: "camera.metering.center.weighted"),
            for: .normal
        )
        button.tintColor = .black
        button.isEnabled = true
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.rowHeight = 35
        return tableView
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setup() {
        backgroundColor = UIColor.authBackgroundColor
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        addSubview(tableView)
        addSubview(headerHStackView)
        headerHStackView.addArrangedSubview(avatarView)
        headerHStackView.addArrangedSubview(userName)
        headerHStackView.addArrangedSubview(cameraButton)
    }
    
    private func setupConstraints() {
        setHeaderHStackContraints()
        setCameraButtonConstraints()
        setTableViewConstraints()
        setAvatarViewConstraints()
    }
    
    private func setHeaderHStackContraints() {
        headerHStackView.translatesAutoresizingMaskIntoConstraints = false
        let headerHStackViewConstraints = [
            headerHStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerHStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            headerHStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(headerHStackViewConstraints)
    }
    
    private func setCameraButtonConstraints() {
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        let cameraButtonContraints = [
            cameraButton.widthAnchor.constraint(equalToConstant: 40),
            cameraButton.heightAnchor.constraint(equalToConstant: 35),
        ]
        NSLayoutConstraint.activate(cameraButtonContraints)
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: headerHStackView.bottomAnchor, constant: 35),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 35),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -35)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private func setAvatarViewConstraints() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        let avatarViewConstraints = [
            avatarView.widthAnchor.constraint(equalToConstant: 32),
            avatarView.heightAnchor.constraint(equalToConstant: 32),
        ]
        NSLayoutConstraint.activate(avatarViewConstraints)
    }

}
