//
//  SubLevels.swift
//  T&A
//
//  Created by Teodik Abrami on 7/9/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation
/*
class SubLevelsSaving: NSObject , NSCoding {
    
 
   
    var sublevel: SubLevels!

    struct PropertyKey {
        static var levelsPics = "levelsPics"
        static var levelsNumber = "levelsNumber"
        static var lock = "lock"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sublevel.levelsPics, forKey: PropertyKey.levelsPics)
        aCoder.encode(sublevel.levelsNumber, forKey: PropertyKey.levelsNumber)
        aCoder.encode(sublevel.lock, forKey: PropertyKey.lock)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let levelsPics = aDecoder.decodeObject(forKey: PropertyKey.levelsPics) as? [String] else { return nil }
        guard let levelNumbers = aDecoder.decodeObject(forKey: PropertyKey.levelsNumber) as? [Int] else { return nil }
        guard let lock = aDecoder.decodeObject(forKey: PropertyKey.lock) as? [Bool] else { return nil }
        
    }
    static func saveAttribute(attribute: SubLevels) {
        NSKeyedArchiver.archiveRootObject(attribute, toFile: archivedURL.path)
    }
    
    static func loadSubLevels() -> SubLevels? {
        if let unArchivedSubLevels = NSKeyedUnarchiver.unarchiveObject(withFile: archivedURL.path) as? SubLevels {
            return unArchivedSubLevels
        }
        return nil
    }
}
 */

struct SubLevels: Codable {
    
    static var archivedURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("T&A-SubLevels").appendingPathExtension(".pr")
    }
    
    var levelsPics: [String] = []
    var levelsNumber: [Int] = []
    var lock: [Bool] = []
    
    static func saveSubLevel(subLevel: SubLevels) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedsubLevel = try? propertyListEncoder.encode(subLevel) {
            try? encodedsubLevel.write(to: archivedURL)
        }
    }
    // decode load kardan
    static func loadedSubLevel() -> SubLevels? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedsubLevelData = try? Data.init(contentsOf: archivedURL), let decodesubLevel = try? propertyListDecoder.decode(SubLevels.self, from: retrievedsubLevelData) {
            return decodesubLevel
        }
        return nil
    }
}

