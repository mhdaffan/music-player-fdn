//
//  LibraryScreen.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

let kLibraryScreen = "Library Screen"

final class LibraryScreen: Screen<Void> {
    
    override var identifier: String {
        return kLibraryScreen
    }
    
    override func build() -> ViewController {
        let viewController = LibraryViewController()
        
        viewController.navigationEvent.on { [weak self] navigation in
            self?.event?(navigation)
        }
        
        return viewController
    }
    
}
