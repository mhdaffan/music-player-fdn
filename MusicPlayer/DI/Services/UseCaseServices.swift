//
//  UseCaseServices.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

extension Resolver {
    
    static func registerAllUseCaseServices() {
        
        register { LibraryUseCaseImpl() as LibraryUseCase }
        register { FavoriteUseCaseImpl() as FavoriteUseCase }
        
    }
    
}
