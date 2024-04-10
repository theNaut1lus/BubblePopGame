//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct StartGameView: View {
    @State var bubble = true
    @EnvironmentObject var startGame : StartGameViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Label(startGame.name, systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Label(String(startGame.numOfBubbles), systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.title)
                    Label(String(startGame.gameTime), systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

#Preview {
    StartGameView().environmentObject(StartGameViewModel())
}
