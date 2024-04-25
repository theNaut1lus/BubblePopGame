//
//  StartGameViewModel.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 9/4/2024.
//

import Foundation


class StartGameViewModel : ObservableObject {
    @Published var name: String = ""
    @Published var gameTime: Double = 60
    @Published var numOfBubbles: Double = 4
}
