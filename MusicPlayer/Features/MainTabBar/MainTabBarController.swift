//
//  MainTabBarController.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    static let defaultTabBar = MainTabBarController()
    
    var coordinatorList: [Coordinator] = []
    var selectedCoordinator: Coordinator {
        return coordinatorList[selectedIndex]
    }
    
    private let libraryCoordinator = LibraryCoordinator()
    private let favoriteCoordinator = FavoriteCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        tabBar.layer.borderWidth = 1
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = .blue
        let unselectedFontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        UITabBarItem.appearance().setTitleTextAttributes(unselectedFontAttribute, for: .normal)
        startCoordinator()
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        coordinatorList = [libraryCoordinator, favoriteCoordinator]
        
        viewControllers = coordinatorList.map { coordinator -> UINavigationController in
            return coordinator.navigationController
        }
    }
    
    private func startCoordinator() {
        favoriteCoordinator.start()
        libraryCoordinator.start()
    }
    
}
