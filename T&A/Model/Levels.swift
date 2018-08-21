//
//  Levels.swift
//  T&A
//
//  Created by Teodik Abrami on 7/10/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

struct LevelsEnabled: Codable {
    
    static var enabling: [Bool] = [true,true,false,false,false]
    
    static var archivedURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("T&A-LevelsEnabled").appendingPathExtension(".pr")
    }
    
    
    static func saveLevelsEnabled(levelsEnabled: LevelsEnabled) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedLevelsEnabled = try? propertyListEncoder.encode(levelsEnabled) {
            try? encodedLevelsEnabled.write(to: archivedURL)
        }
    }
    // decode load kardan
    static func loadedLevelsEnabled() -> LevelsEnabled? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedLevelsEnabledData = try? Data.init(contentsOf: archivedURL), let decodeLevelsEnabled = try? propertyListDecoder.decode(LevelsEnabled.self, from: retrievedLevelsEnabledData) {
            return decodeLevelsEnabled
        }
        return nil
    }
}
