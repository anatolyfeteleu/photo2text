//
//  ViewController.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 22.01.2023.
//

import Combine
import UIKit
import Alamofire


class AuthViewController: UIViewController {
    var coordinator: Coordinator?
    
    private var cancellables: Set<AnyCancellable> = []
    private let notificationCenter = NotificationCenter.default
    
    var authView = AuthView()
    var viewModel: AuthViewModel!
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configureViews()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: life cycle -
    
    private func setup() {}
    
    private func configureViews() {
        authView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        authView.adviceButton.addTarget(self, action: #selector(adviceButtonTapped), for: .touchUpInside)
    }
    
    private func configureBindings() {
        notificationCenter  // cлушается поле и сеттится в VM
            .publisher(for: UITextField.textDidChangeNotification, object: authView.loginTextField)
            .receive(on: DispatchQueue.main)
            .map { $0.object as? UITextField }
            .map { $0?.text ?? "" }
            .assign(to: \.login, on: viewModel.authManager)
            .store(in: &cancellables)
        notificationCenter  // cлушается поле и сеттится в VM
            .publisher(for: UITextField.textDidChangeNotification, object: authView.passwordTextField)
            .receive(on: DispatchQueue.main)
            .map { $0.object as? UITextField }
            .map { $0?.text ?? "" }
            .assign(to: \.password, on: viewModel.authManager)
            .store(in: &cancellables)
        viewModel.authManager.isFormCorrect  // слушается и сеттит значение в View
            .sink { [weak self] recievedValue in
                guard let self = self else { return }
                if recievedValue == true {
                    self.authView.submitButton.backgroundColor = .authReadyToSubmitButtonColor
                } else {
                    self.authView.submitButton.backgroundColor = .authSubmitButtonColor
                }
                self.authView.submitButton.isEnabled = recievedValue
            }
            .store(in: &cancellables)
        viewModel.authManager.$state  // Слушается и сетттит View
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.authView.submitButton.isHidden = false
                    self.authView.submitButton.isEnabled = false
                    self.authView.submitButton.backgroundColor = .authSubmitButtonColor
                case .success:
                    MUserDefaults.username = self.viewModel.authManager.login
                    
                    self.authView.submitButton.isHidden = false
                    self.authView.submitButton.isEnabled = false
                    
                    self.coordinator?.credentials.login()
                    self.coordinator?.showMain()
                case .error:
                    self.authView.submitButton.isHidden = false
                    self.authView.submitButton.isEnabled = false
                    self.authView.submitButton.backgroundColor = .authSubmitButtonColor
                case .none:
                    break
                }
                self.authView.activityIndicatorView.stopAnimating()
            }
            .store(in: &cancellables)
        viewModel.adviceManager.$advice
            .receive(on: DispatchQueue.main)
            .map { recievedValue -> String? in
                guard let recievedValue = recievedValue else { return nil }
                var advice = recievedValue.advice
                advice.remove(at: advice.index(before: advice.endIndex))
                return advice
            }
            .sink { [weak self] advice in
                if advice != nil {
                    self?.authView.adviceText = "\u{201c}\(advice!)\u{201e}"
                } else {
                    self?.authView.adviceText = "¯\\_(ツ)_/¯"
                }
            }
            .store(in: &cancellables)
        viewModel.adviceManager.$activated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recievedValue in
                guard let self = self else { return }
                switch recievedValue {
                case true:
                    self.viewModel.loadAdvice()
                    self.authView.adviceButton.tintColor = .systemTeal
                case false:
                    self.viewModel.adviceManager.advice = nil
                    self.authView.adviceButton.tintColor = .systemGray
                }
                
            }
            .store(in: &cancellables)
    }
    
    // MARK: - button actions
    
    @objc private func submitTapped() {
        viewModel.authManager.submitLogin()
        authView.endEditing(true)
        authView.activityIndicatorView.startAnimating()
    }
    
    @objc private func adviceButtonTapped() {
        viewModel.adviceManager.toggleAdvice()
    }
    
    // MARK: button actions -
}
