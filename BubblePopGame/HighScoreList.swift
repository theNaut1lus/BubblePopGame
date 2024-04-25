//
//  HighScoreList.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 13/4/2024.
//

import Foundation
import SwiftData

//use swift data hobject to persist the names and highscore into model list

@Model
final class HighScoreList {
    var id = UUID()
    var name: String = ""
    var score: Double = 0.0
    
    init(name: String = "", score: Double = 0.0) {
        self.name = name
        self.score = score
    }
}
