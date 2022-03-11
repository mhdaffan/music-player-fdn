//
//  RepositoryServices.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

extension Resolver {
    
    static func registerAllRepositoryServices() {
    
        register { LibraryRepositoryImpl() as LibraryRepository }
        register { FavoriteRepositoryImpl() as FavoriteRepository }
        
    }
    
}
