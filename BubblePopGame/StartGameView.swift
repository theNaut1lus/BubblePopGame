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
                .fill(.gray)
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
                HStack {
                    Button {
                        print("Button Popped")
                        bubble.toggle()
                    } label: {
                        Circle().fill(bubble ? Gradient(colors: [.red, .orange, .orange]) : Gradient(colors: [.clear]))
                    }
                    Circle().fill(.clear)
                    Circle()
                }
                HStack {
                    Circle()
                    Circle()
                    Circle()
                }
                HStack {
                    Circle()
                    Circle()
                    Circle()
                }
                HStack {
                    Circle()
                    Circle()
                    Circle()
                }
                HStack {
                    Circle()
                    Circle()
                    Circle()
                }
            }
        }
    }
}

#Preview {
    StartGameView().environmentObject(StartGameViewModel())
}
