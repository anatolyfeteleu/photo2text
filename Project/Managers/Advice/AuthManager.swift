//
//  AuthManager.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 19.02.2023.
//

import Foundation
import Combine


class AuthManager: ObservableObject {
    enum States {
        case loading
        case success
        case error
        case none
    }
    
    static let shared = {
        return AuthManager()
    }()
    
    @Published var login: String = String()
    @Published var password: String = String()
    @Published var state: States = .none
    
    var isLoginCorrect: AnyPublisher<Bool, Never> {
        $login
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    var isPasswordCorrect: AnyPublisher<Bool, Never> {
        $password
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isFormCorrect: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isLoginCorrect, isPasswordCorrect)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    var isLoggedIn: Bool {
        return state == .success
    }
    
    func submitLogin() {
        state = .loading
        // Simulate HTTP-request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { [weak self] in
            guard let self = self else { return }
            if self.isCorrect() {
                self.state = .success
            } else {
                self.state = .error
            }
        }
    }
    
    func isCorrect() -> Bool {
        return login == "admin" && password == "123"
    }
}
