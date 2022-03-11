//
//  FavoriteUseCase.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

protocol FavoriteUseCase {
    func getAllLocalTracks() -> [MusicTrackLocalDataModel]
    func removeFromLocal(item: MusicTrackLocalDataModel)
}

struct FavoriteUseCaseImpl: FavoriteUseCase {
    
    private let repository: FavoriteRepository = Resolver.resolve()
    
    func getAllLocalTracks() -> [MusicTrackLocalDataModel] {
        return repository.getAllLocalTracks()
    }
    
    func removeFromLocal(item: MusicTrackLocalDataModel) {
        repository.removeFromLocal(item: item)
    }
    
}
