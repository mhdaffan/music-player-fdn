//
//  TrackModel.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

struct TrackListModel {
    var header: HeaderModel
    var trackList: [TrackModel]
}

struct TrackModel {
    var trackId: Int
    var trackName: String
    var artistName: String
    var isFavorite: Bool = false
}

struct HeaderModel {
    var available: Int
}
