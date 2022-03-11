//
//  SubscribeResult.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

enum SubscribeResult<Value> {
    case Success(Value)
    case Failure(Error)
}
