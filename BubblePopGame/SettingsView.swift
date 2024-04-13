//
//  SettingsView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var startGameViewModel : StartGameViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            VStack{
                Label("SettingsView", systemImage: "")
                    .foregroundStyle(.regularMaterial)
                    .fontWeight(.black)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Enter Name")
                    .foregroundStyle(.regularMaterial)
                    .fontWeight(.black)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Enter Name", text: $startGameViewModel.name)
                    .padding(.all, 20.0)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Text("Game Time")
                    .foregroundStyle(.regularMaterial)
                    .fontWeight(.bold)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Slider(value: $startGameViewModel.gameTime, in: 0...60, step: 1)
                    .padding(.horizontal, 20.0)
                
                Text("\(Int(startGameViewModel.gameTime))")
                    .padding()
                Text("Max number of bubbles")
                    .foregroundStyle(.regularMaterial)
                    .fontWeight(.bold)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Slider(value: $startGameViewModel.numOfBubbles, in: 0...15, step: 1)
                    .padding(.horizontal, 20.0)
                Text("\(Int(startGameViewModel.numOfBubbles))")
                    .padding()
                NavigationLink(destination: StartGameView().environmentObject(startGameViewModel), label: {Text("Start Game!").font(.title)})
                
            }
            
        }
    }
}

#Preview {
    SettingsView().environmentObject(StartGameViewModel())
}
