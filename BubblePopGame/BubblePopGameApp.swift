//
//  BubblePopGameApp.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

@main
struct BubblePopGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(startGameViewModel: StartGameViewModel())
        }
    }
}
