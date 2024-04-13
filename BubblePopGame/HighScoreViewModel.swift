//
//  HighScoreViewModel.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import Foundation
import SwiftData

@Model
final class HighScoreViewModel {
    var id = UUID()
    var name: String = ""
    var score: Double = 0.0
    
    init(name: String = "", score: Double = 0.0) {
        self.name = name
        self.score = score
    }
}


//use swift data here to persist the names and highscore
