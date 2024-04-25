//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
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
                    Image(systemName: "soccerball.circle")
                        .aspectRatio(contentMode: .fill)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 4)
                    NavigationLink(destination: SettingsView()
                        .environmentObject(startGameViewModel)
                        .environmentObject(highScoreViewModel), label: {Text("New Game").font(.title)})
                        .padding(50)
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

#Preview {
    let container = try! ModelContainer(for: HighScoreList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    
    let model = HighScoreList(name: "Sid", score: 832)
    context.insert(model)
    try! context.save()
        
    return ContentView(startGameViewModel: StartGameViewModel(), highScoreViewModel: HighScoreViewModel())
        .modelContainer(container)
}
