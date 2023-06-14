//
//  CoordinatorImp.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 15.03.2023.
//

import UIKit

class CoordinatorImp: Coordinator {

    var navigationController: UINavigationController
    let credentials: Credentials = Credentials.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    func pop() {
        return
    }
    
    func start() {
        if credentials.isAuthorized {
             showMain()
        } else {
             showLogin()
        }
    }
    
    func showLogin() {
        let vc = AuthViewController()
        vc.coordinator = self
        vc.viewModel = AuthViewModel()
        
        push(viewController: vc, animated: false)
    }
    
    func showMain() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.viewModel = MainViewModel()
        
        navigationController.viewControllers.removeAll()
        
        push(viewController: vc, animated: false)
    }
    
    
}
