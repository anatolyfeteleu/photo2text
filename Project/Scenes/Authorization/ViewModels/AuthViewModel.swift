//
//  ViewModel.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 22.01.2023.
//

import Foundation


class AuthViewModel {
    let adviceManager = AdviceManager.shared
    let authManager = AuthManager.shared
    
    func loadAdvice() {
        adviceManager.loadAdvices()
    }
}
