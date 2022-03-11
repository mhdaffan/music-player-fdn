//
//  DependencyManager.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerAllRemoteDataSourceServices()
        registerAllLocaleDataSourceServices()
        registerAllRepositoryServices()
        registerAllViewModelServices()
        registerAllMapperServices()
        registerAllUseCaseServices()
    }
    
}
