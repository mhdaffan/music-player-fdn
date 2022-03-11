//
//  LibraryRepository.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 10/03/22.
//

import RxSwift

protocol LibraryRepository {
    func getTrackList(page: Int, pageSize: Int, artistName: String) -> Observable<TrackListModel>
    func getAllLocalTracks() -> [MusicTrackLocalDataModel]
    func saveToLocal(item: MusicTrackLocalDataModel)
}

struct LibraryRepositoryImpl: LibraryRepository {
    
    private let remote: LibraryRemoteDataSource = Resolver.resolve()
    private let local: MusicTrackLocalDataSource = Resolver.resolve()
    private let mapper: LibraryMapper = Resolver.resolve()
    
    func getTrackList(page: Int, pageSize: Int, artistName: String) -> Observable<TrackListModel> {
        return remote.getTrackList(page: page, pageSize: pageSize, artistName: artistName)
            .map { mapper.trackListResponseModelToDomain(response: $0) }
    }
    
    func getAllLocalTracks() -> [MusicTrackLocalDataModel] {
        return local.getAllLocalTracks()
    }
    
    func saveToLocal(item: MusicTrackLocalDataModel) {
        return local.saveToLocal(item: item)
    }
    
}
