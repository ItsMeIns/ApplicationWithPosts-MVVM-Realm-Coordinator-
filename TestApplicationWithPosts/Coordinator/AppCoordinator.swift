//
//  AppCoordinator.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 14.11.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    var windowScene: UIWindow? { get }
}

class AppCoordinator: AppCoordinatorProtocol {
    var windowScene: UIWindow?
    
    var childCoordinator: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(windowScene: UIWindow?) {
        self.windowScene = windowScene
        self.navigationController = UINavigationController()
    }
    
    func start() {
        windowScene?.rootViewController = navigationController
        windowScene?.makeKeyAndVisible()
        goToMain()
    }
    
    func finish() {
        
    }
    
    private func goToMain() {
        let coordinator = MainViewCoordinator(navigationController: navigationController)
        childCoordinator.append(coordinator)
        coordinator.start()
    }
    
    
}
