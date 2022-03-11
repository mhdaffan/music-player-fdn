//
//  File.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import Foundation

internal final class File {

    static func path(_ name: String, extension ext: String = "") -> URL? {

        guard let documentURL = try? FileManager.default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: true) else {

                    return nil
        }

        if ext.isEmpty {
            return documentURL.appendingPathComponent("\(name)")
        }

        return documentURL.appendingPathComponent("\(name).\(ext)")
    }
    
}
