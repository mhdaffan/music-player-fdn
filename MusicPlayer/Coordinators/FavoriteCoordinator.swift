//
//  FavoriteCoordinator.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import UIKit

class FavoriteCoordinator: Coordinator {

    var navigationController: BaseNavigationController = BaseNavigationController()
    
    var screenStack: [Screenable] = []
    
    var onCompleted: ((ScreenResult?) -> Void)?
    
    func start() {
        set([FavoriteScreen(())])
        updateTitle()
    }
    
    func updateTitle() {
        guard let viewController = navigationController.viewControllers.first else {
            return
        }
        viewController.title = favoriteStr
        viewController.tabBarItem.image = .icsOFavorite
        viewController.tabBarItem.selectedImage = .icsFFavorite
    }
    
    func showScreen(identifier: String, navigation: Navigation) {

    }
    
}
