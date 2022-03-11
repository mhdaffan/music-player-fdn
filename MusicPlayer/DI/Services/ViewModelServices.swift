//
//  ViewModelServices.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

extension Resolver {
    
    static func registerAllViewModelServices() {
    
        register { LibraryViewModel() }
        register { FavoriteViewModel() }
        
    }
    
}
