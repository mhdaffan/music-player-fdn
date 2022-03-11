//
//  RealmConfiguration.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import Foundation
import RealmSwift

internal enum RealmConfiguration: String {

    case musicLocalTrack = "MusicLocalTrack"
}

// MARK: - Realm Configuration

extension RealmConfiguration {

    var value: Realm.Configuration {
        let fileURL = File.path(self.rawValue, extension: "realm")

        return Realm.Configuration(
            fileURL: fileURL,
            readOnly: false,
            schemaVersion: 1,
            objectTypes: self.objectTypes
        )
    }

    private var objectTypes: [ RealmSwift.Object.Type ]? {

        switch self {
        case .musicLocalTrack:
            return [ MusicTrackLocalDataModel.self ]
        }
    }
}
