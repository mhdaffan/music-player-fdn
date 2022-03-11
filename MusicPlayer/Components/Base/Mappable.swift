//
//  Mappable.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import JASON

internal protocol Mappable {

    init?(json: JSON)

    func toDictionary() -> [String: Any]
}

extension Mappable {

    func toDictionary() -> [String: Any] {
        return [:]
    }

}
