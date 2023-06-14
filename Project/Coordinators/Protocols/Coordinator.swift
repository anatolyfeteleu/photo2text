//
//  Coordinator.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 15.03.2023.
//

import UIKit

protocol Coordinator {
    
    var credentials: Credentials { get }
    
    var navigationController: UINavigationController { get set }
    
    func push(viewController: UIViewController, animated: Bool)
    
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    func pop()
    
    func start()
    
    func showMain()
    
    func showLogin()
    
}
