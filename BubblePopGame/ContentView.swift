//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var startGameViewModel: StartGameViewModel
    @StateObject var highScoreViewModel: HighScoreViewModel
    
    var body: some View {
        NavigationView{
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
                    NavigationLink(destination: SettingsView().environmentObject(startGameViewModel), label: {Text("New Game").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)})
                        .padding(50)
                    NavigationLink(destination: HighScoreView().environmentObject(highScoreViewModel), label: {Text("High Score").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)})
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView(startGameViewModel: StartGameViewModel(), highScoreViewModel: HighScoreViewModel())
}
