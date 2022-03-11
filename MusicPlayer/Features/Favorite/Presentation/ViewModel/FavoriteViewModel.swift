//
//  FavoriteViewModel.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

final class FavoriteViewModel {
    
    private let useCase: FavoriteUseCase = Resolver.resolve()
    
    var localData: [MusicTrackLocalDataModel] = []
    
    func getAllLocalTracks() {
        localData = useCase.getAllLocalTracks()
    }
    
    func removeFromLocal(item: MusicTrackLocalDataModel) {
        useCase.removeFromLocal(item: item)
    }
    
}
