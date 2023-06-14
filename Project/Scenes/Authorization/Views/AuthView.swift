//
//  AuthView.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 25.01.2023.
//

import UIKit


class AuthView: UIView {
    
    var adviceText: String = "" {
        didSet {
            adviceLabel.attributedText = NSAttributedString(
                string: adviceText,
                attributes: [.tracking: 1.5, .font: UIFont.italicSystemFont(ofSize: 12)]
            )
        }
    }
    var titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: LocalizedStrings.welcoming_message,
            attributes: [.tracking: 5])
        label.textAlignment = .center
        label.font = .loginTitleFont
        return label
    }()
    var loginLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: LocalizedStrings.login_label,
            attributes: [.tracking: 2.5])
        return label
    }()
    var adviceLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 5
            label.textAlignment = .center
            return label
    }()
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .nickname
        textField.attributedPlaceholder = NSAttributedString(
            string: LocalizedStrings.login_placeholder,
            attributes: [.font: UIFont.italicSystemFont(ofSize: 14)])
        return textField
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: LocalizedStrings.password_label,
            attributes: [.tracking: 2.5])
        return label
    }()
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(
            string: LocalizedStrings.password_placeholder,
            attributes: [.font: UIFont.italicSystemFont(ofSize: 14)])
        return textField
    }()
    
    var loginVStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    var passwordVStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    var authVStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 25
        return stack
    }()
    var headerHStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    var submitButton: UIButton = {
       let button = UIButton()
        button.setTitle(
            LocalizedStrings.submit_label,
            for: .normal)
        return button
    }()
    
    var adviceButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "peacesign"),
            for: .normal)
        button.tintColor = .systemTeal
        button.isEnabled = true
        return button
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
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
        addSubview(activityIndicatorView)
        
        addSubview(headerHStackView)
        headerHStackView.addArrangedSubview(titleLabel)
        headerHStackView.addArrangedSubview(adviceButton)
        
        addSubview(loginVStackView)
        loginVStackView.addArrangedSubview(loginLabel)
        loginVStackView.addArrangedSubview(loginTextField)
        
        addSubview(passwordVStackView)
        passwordVStackView.addArrangedSubview(passwordLabel)
        passwordVStackView.addArrangedSubview(passwordTextField)
        
        addSubview(authVStackView)
        authVStackView.addArrangedSubview(loginVStackView)
        authVStackView.addArrangedSubview(passwordVStackView)
        
        addSubview(submitButton)
        addSubview(adviceLabel)
    }
    
    private func setupConstraints() {
        setActivityIndicatorConstraints()
        setAuthVStackConstraints()
        setHeaderHStackViewConstraints()
        setSubmitButtonConstraints()
        setAdviceLabelConstraints()
    }
    
    private func setHeaderHStackViewConstraints() {
        headerHStackView.translatesAutoresizingMaskIntoConstraints = false
        let headerHStackViewConstraints = [
            headerHStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            headerHStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ]
        NSLayoutConstraint.activate(headerHStackViewConstraints)
    }
    
    private func setAuthVStackConstraints() {
        authVStackView.translatesAutoresizingMaskIntoConstraints = false
        let authVStackViewConstraints = [
            authVStackView.topAnchor.constraint(equalTo: headerHStackView.bottomAnchor, constant: 50),
            authVStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 50),
            authVStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -50),
        ]
        NSLayoutConstraint.activate(authVStackViewConstraints)
    }
    
    private func setSubmitButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        let submitButtonConstraints = [
            submitButton.topAnchor.constraint(equalTo: authVStackView.bottomAnchor, constant: 35),
            submitButton.leftAnchor.constraint(equalTo: authVStackView.leftAnchor),
            submitButton.rightAnchor.constraint(equalTo: authVStackView.rightAnchor),
        ]
        NSLayoutConstraint.activate(submitButtonConstraints)
        submitButton.layer.cornerRadius = 7.5
    }
    
    private func setAdviceLabelConstraints() {
        adviceLabel.translatesAutoresizingMaskIntoConstraints = false
        let adviceLabelConstraints = [
            adviceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            adviceLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            adviceLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            adviceLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 50),
            adviceLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -50),
        ]
        NSLayoutConstraint.activate(adviceLabelConstraints)
    }
    
    private func setActivityIndicatorConstraints() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        let activityIndicatorViewContraints = [
            activityIndicatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ]
        NSLayoutConstraint.activate(activityIndicatorViewContraints)
    }

}
