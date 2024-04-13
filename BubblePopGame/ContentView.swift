//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var startGameViewModel: StartGameViewModel
    
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
                    NavigationLink(destination: SettingsView().environmentObject(startGameViewModel), label: {Text("New Game").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)})
                        .padding(50)
                    NavigationLink(destination: HighScoreView(), label: {Text("High Score").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)})
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
    ContentView(startGameViewModel: StartGameViewModel())
}
