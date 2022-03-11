//
//  MusicEndpoint.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 10/03/22.
//

import Foundation
import Moya

enum MusicEndpoint {
    case searchTrack (
        page: Int,
        pageSize: Int,
        artistName: String
    )
}

extension MusicEndpoint: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.musixmatch.com/ws/1.1") else {
            fatalError("")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .searchTrack:
            return "track.search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchTrack:
            return .get
        }
    }
    
    var task: Task {
        
        switch self {
        case let .searchTrack(page, pageSize, artistName):
            let params: [String: Any] = [
                "apikey": "4f7549e47cbd524ddda8f7ca760b4277",
                "page": page,
                "page_size": pageSize,
                "q_artist": artistName
            ]
            
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        let sample = "{\"data\": []}"
        
        guard let data = sample.data(using: String.Encoding.utf8) else {
            return Data()
        }
        return data
    }
    
    var headers: [String: String]? {
        return [ "Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .none
    }
}
