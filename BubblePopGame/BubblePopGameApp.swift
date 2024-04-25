//
//  BubblePopGameApp.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

@main
struct BubblePopGameApp: App {
    //get swift data working
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            HighScoreList.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView(startGameViewModel: StartGameViewModel(), highScoreViewModel: HighScoreViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
