//
//  MusicTrackLocalDataSource.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

protocol MusicTrackLocalDataSource {
    func getAllLocalTracks() -> [MusicTrackLocalDataModel]
    func saveToLocal(item: MusicTrackLocalDataModel)
    func removeFromLocal(item: MusicTrackLocalDataModel)
}

struct MusicTrackLocalDataSourceImpl: MusicTrackLocalDataSource {
    
    private let realmRepository: RealmRepository<MusicTrackLocalDataModel> = RealmRepository<MusicTrackLocalDataModel>(.musicLocalTrack)
    
    func getAllLocalTracks() -> [MusicTrackLocalDataModel] {
        realmRepository.fetch()
        
        return realmRepository.allItem() ?? []
    }
    
    func saveToLocal(item: MusicTrackLocalDataModel) {
        realmRepository.insert(item)
    }
    
    func removeFromLocal(item: MusicTrackLocalDataModel) {
        realmRepository.delete(item)
    }
    
}
