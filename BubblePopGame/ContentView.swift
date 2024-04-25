//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    //defined the 2 env variables used by the entire nav stack
    @StateObject var startGameViewModel: StartGameViewModel
    @StateObject var highScoreViewModel: HighScoreViewModel
    
    var body: some View {
        NavigationStack{
            ZStack {
                Rectangle()
                    .fill(.titlePageBackground)
                    .ignoresSafeArea()
                VStack {
                    Label("Bubble Pop", systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.largeTitle)
                    Spacer()
                    Image(.bubble)
                        .aspectRatio(contentMode: .fill)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 4)
                    //Navigation to game settings view
                    NavigationLink(destination: SettingsView()
                        .environmentObject(startGameViewModel)
                        .environmentObject(highScoreViewModel), label: {Text("New Game").font(.title)})
                        .padding(10)
                    //Direct navigation to high score view
                    NavigationLink(destination: HighScoreView()
                        .environmentObject(startGameViewModel)
                        .environmentObject(highScoreViewModel)
                    , label: {Text("High Score").font(.title)})
                    Spacer()
                    Label("Made by: Sid Aulakh", systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.semibold)
                        .font(.footnote)
                }
                .padding()
            }
        }
    }
}

//to make preview behave well with with Swift Data
#Preview {
    let container = try! ModelContainer(for: HighScoreList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    
    let model = HighScoreList(name: "Sid", score: 832)
    context.insert(model)
    try! context.save()
        
    return ContentView(startGameViewModel: StartGameViewModel(), highScoreViewModel: HighScoreViewModel())
        .modelContainer(container)
}
