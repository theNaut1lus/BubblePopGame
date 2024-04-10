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
    @Published var HighScores: [ScoreDetail] = []
}
