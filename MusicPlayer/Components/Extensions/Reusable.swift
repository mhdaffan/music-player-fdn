//
//  Reusable.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

public protocol Reusable: AnyObject {
    
    static var identifier: String { get }
}

public extension Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
