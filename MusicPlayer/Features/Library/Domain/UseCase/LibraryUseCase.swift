//
//  LibraryUseCase.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 10/03/22.
//

import RxSwift

protocol LibraryUseCase {
    func getTrackList(page: Int, pageSize: Int, artistName: String) -> Observable<TrackListModel>
    func getAllLocalTracks() -> [MusicTrackLocalDataModel]
    func saveToLocal(item: MusicTrackLocalDataModel)
}

struct LibraryUseCaseImpl: LibraryUseCase {
    
    private let repository: LibraryRepository = Resolver.resolve()
    
    func getTrackList(page: Int, pageSize: Int, artistName: String) -> Observable<TrackListModel> {
        return repository.getTrackList(page: page, pageSize: pageSize, artistName: artistName)
    }
    
    func getAllLocalTracks() -> [MusicTrackLocalDataModel] {
        return repository.getAllLocalTracks()
    }
    
    func saveToLocal(item: MusicTrackLocalDataModel) {
        return repository.saveToLocal(item: item)
    }
    
}
