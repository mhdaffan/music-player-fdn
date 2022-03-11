//
//  MusicTrackLocalDataModel.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import RealmSwift

final class MusicTrackLocalDataModel: Object {
    
    @objc dynamic var trackId: Int = -1
    @objc dynamic var trackName: String = ""
    @objc dynamic var artistName: String = ""
    
    override static func primaryKey() -> String? {
        return "trackId"
    }
    
    required convenience init(trackId: Int, trackName: String, artistName: String) {
        self.init()
        self.trackId = trackId
        self.trackName = trackName
        self.artistName = artistName
    }
    
}
