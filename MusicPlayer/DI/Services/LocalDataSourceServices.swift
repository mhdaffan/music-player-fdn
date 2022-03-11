//
//  LocalDataSourceServices.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

extension Resolver {
    
    static func registerAllLocaleDataSourceServices() {
        
        register { MusicTrackLocalDataSourceImpl() as MusicTrackLocalDataSource }
        
    }
    
}
