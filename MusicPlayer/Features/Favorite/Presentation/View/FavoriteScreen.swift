//
//  FavoriteScreen.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

let kFavoriteScreen = "Favorite Screen"

final class FavoriteScreen: Screen<Void> {
    
    override var identifier: String {
        return kFavoriteScreen
    }
    
    override func build() -> ViewController {
        let viewController = FavoriteViewController()
        
        viewController.navigationEvent.on { [weak self] navigation in
            self?.event?(navigation)
        }
        
        return viewController
    }
    
}
