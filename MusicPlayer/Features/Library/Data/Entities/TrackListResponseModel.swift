//
//  TrackListResponseModel.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import JASON

struct TrackListResponseModel {
    var header: HeaderResponseModel
    var trackList: [TrackResponseModel]
}

extension TrackListResponseModel: Mappable {
    
    init?(json: JSON) {
        guard let trackList = json["message"]["body"]["track_list"].jsonArray,
              let header = HeaderResponseModel(json: json["message"]["header"]) else {
            return nil
        }
        
        self.header = header
        self.trackList = trackList.compactMap { json -> TrackResponseModel? in
            return TrackResponseModel(json: json["track"])
        }
    }
    
}

struct TrackResponseModel {
    var trackId: Int
    var trackName: String
    var artistName: String
}

extension TrackResponseModel: Mappable {
    
    init?(json: JSON) {
        guard let trackId = json["track_id"].int,
              let trackName = json["track_name"].string,
              let artistName = json["artist_name"].string else {
                  return nil
              }
        
        self.trackId = trackId
        self.trackName = trackName
        self.artistName = artistName
    }
    
}

struct HeaderResponseModel {
    var available: Int
}

extension HeaderResponseModel: Mappable {
    
    init?(json: JSON) {
        guard let available = json["available"].int else {
            return nil
        }
        self.available = available
    }
    
}
