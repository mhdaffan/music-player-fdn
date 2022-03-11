//
//  LibraryRemoteDataSource.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 10/03/22.
//

import RxSwift

protocol LibraryRemoteDataSource {
    func getTrackList(page: Int, pageSize: Int, artistName: String) -> Observable<TrackListResponseModel>
}

struct LibraryRemoteDataSourceImpl: LibraryRemoteDataSource {
    
    private let provider = APIProvider<MusicEndpoint>.provider()
    
    func getTrackList(page: Int, pageSize: Int, artistName: String) -> Observable<TrackListResponseModel> {
        let requestTarget = MusicEndpoint.searchTrack(
            page: page,
            pageSize: pageSize,
            artistName: artistName)
        
        return provider.rx.request(requestTarget)
            .asObservable()
            .mapObject(type: TrackListResponseModel.self)
    }
    
}
