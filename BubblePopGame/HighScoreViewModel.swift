//
//  HighScoreViewModel.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import Foundation

//The details for current user to be passed to high score view, then saved into the HighScoreList using swift Data

class HighScoreViewModel: ObservableObject {
    @Published var id = UUID()
    @Published var name: String = ""
    @Published var score: Double = 0.0
}
