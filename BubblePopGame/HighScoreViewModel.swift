//
//  HighScoreViewModel.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import Foundation

struct ScoreDetail: Identifiable {
    var id = UUID()
    var name: String
    var score: Int
}

class HighScoreViewModel: ObservableObject {
    @Published var HighScores: [ScoreDetail] = [
    ScoreDetail(name: "sample", score: 1),
    ScoreDetail(name: "test", score: 10)
    ]
}

//use swift data here to persist the names and highscore
