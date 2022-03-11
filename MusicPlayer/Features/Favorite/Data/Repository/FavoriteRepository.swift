//
//  FavoriteRepository.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

protocol FavoriteRepository {
    func getAllLocalTracks() -> [MusicTrackLocalDataModel]
    func removeFromLocal(item: MusicTrackLocalDataModel)
}

struct FavoriteRepositoryImpl: FavoriteRepository {
    
    private let local: MusicTrackLocalDataSource = Resolver.resolve()
    
    func getAllLocalTracks() -> [MusicTrackLocalDataModel] {
        return local.getAllLocalTracks()
    }
    
    func removeFromLocal(item: MusicTrackLocalDataModel) {
        local.removeFromLocal(item: item)
    }
    
}
