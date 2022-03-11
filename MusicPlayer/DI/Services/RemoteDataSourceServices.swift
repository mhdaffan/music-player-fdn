//
//  RemoteDataSourceServices.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

extension Resolver {
    
    static func registerAllRemoteDataSourceServices() {
    
        register { LibraryRemoteDataSourceImpl() as LibraryRemoteDataSource }
        
    }
    
}
