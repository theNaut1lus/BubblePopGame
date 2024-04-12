//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let position: CGPoint
    let color: Color
    let creationTime: Date
    
    static func randomColorSelector() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

struct StartGameView: View {
    @State private var bubbles = [Bubble]()
    @State private var score = 0
    let bubbleSize: CGFloat = 75
    
    @EnvironmentObject var startGame : StartGameViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Label(startGame.name, systemImage: "")
                        .padding(.leading, 20.0)
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Label(String(startGame.numOfBubbles), systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.title)
                    Label(String(startGame.gameTime), systemImage: "")
                        .padding(.trailing, 20.0)
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .onReceive(timer, perform: { _ in
                            if startGame.gameTime > 0 {
                                startGame.gameTime -= 1
                            }
                                    
                        })
                    
                }
                Spacer()
                ZStack {
                    ForEach(bubbles) {bubble in
                        Circle()
                            .foregroundStyle(bubble.color)
                            .frame(width: bubbleSize, height: bubbleSize)
                            .position(bubble.position)
                            .onTapGesture {
                                //pop bubble logic
                            }
                    }
                }
                .onAppear() {
                    //start the game
                }
            }
        }
    }
}

#Preview {
    StartGameView().environmentObject(StartGameViewModel())
}
