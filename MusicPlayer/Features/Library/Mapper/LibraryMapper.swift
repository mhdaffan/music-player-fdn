//
//  LibraryMapper.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 10/03/22.
//

protocol LibraryMapper {
    func trackListResponseModelToDomain(response: TrackListResponseModel) -> TrackListModel
}

struct LibraryMapperImpl: LibraryMapper {
    
    func trackListResponseModelToDomain(response: TrackListResponseModel) -> TrackListModel {
        let header = HeaderModel(available: response.header.available)
        let trackList = response.trackList.map { item -> TrackModel in
            return TrackModel(
                trackId: item.trackId,
                trackName: item.trackName,
                artistName: item.artistName)
        }
        
        return TrackListModel(header: header, trackList: trackList)
    }
}
