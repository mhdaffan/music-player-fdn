//
//  MoyaResponse+JASON.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import Moya
import JASON

internal extension Response {

    func mapObject<T: Mappable>(withKeyPath keyPath: [Any] = []) -> T? {

        let bodyJSON = createBodyJSON(keyPath: keyPath)

        return T(json: bodyJSON)
    }
    
    private func createBodyJSON(keyPath: [Any]) -> JSON {

        return keyPath.reduce(JSON(data)) { json, currentKeypath in

            return json[path: currentKeypath]
        }
    }
    
}
