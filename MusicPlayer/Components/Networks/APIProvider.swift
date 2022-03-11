//
//  APIProvider.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 10/03/22.
//

import Moya

internal final class APIProvider<Target: TargetType> {

    static func provider() -> MoyaProvider<Target> {
        return MoyaProvider()
    }
    
}
