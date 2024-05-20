//
//  MainVIewCoordinator.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 14.11.2023.
//

import UIKit

final class MainViewCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController()
        viewController.mainViewModel = viewModel
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func finish() {
        //
    }
    
    
    
}
