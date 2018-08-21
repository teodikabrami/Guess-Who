//
//  Game.swift
//  Guess Who!!!
//
//  Created by Teodik Abrami on 6/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation


struct Levels: Codable {
    
    static var listOfWords = [(imageName: "1", numberOfLetters: 12, fullName: "ELVISPRESLEY", numberOfHints: 4, levelcomplete: false, firsthint: true, secondHint: true, thirdHint: true, forthhint: true),
                              (imageName: "2", numberOfLetters: 13, fullName: "ELVISPRESLEYY", numberOfHints: 4, levelcomplete: false, firsthint: true, secondHint: true, thirdHint: true, forthhint: true)]
    
    
    
    static var archivedURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("T&A-Levels").appendingPathExtension(".pr")
    }
    
    
    static func saveLevels(levels: Levels) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedLevels = try? propertyListEncoder.encode(levels) {
            try? encodedLevels.write(to: archivedURL)
        }
    }
    // decode load kardan
    static func loadedLevels() -> Levels? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedLevelsData = try? Data.init(contentsOf: archivedURL), let decodeLevels = try? propertyListDecoder.decode(Levels.self, from: retrievedLevelsData) {
            return decodeLevels
        }
        return nil
    }
}

struct Game {
    
    
    var levelcomplete: Bool
    var imageName: String
    var numberOfLetter: Int
    var fullName: String
    var numberOfHints: Int
    var guessedCombination: String
    var firstHint: Bool
    var secondHint: Bool
    var thirdHint: Bool
    var forthHint: Bool
    
    
    func makeArray() -> [String] {
        var nameCharacterArray: [String] = []
        for character in fullName {
            nameCharacterArray.append("\(character)")
        }
        return nameCharacterArray
    }
    
  
    
   
}
