//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct ColorWeightValue: Identifiable ,Equatable {
    let id = UUID()
    let color: Color
    let score: Int
    let probability: Int
}

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let position: CGPoint
    let color: Color
    let scoreValue: Int
    let creationTime: Date
    let colorList: [ColorWeightValue] = [
        ColorWeightValue(color: .red,score: 1,probability: 40),
        ColorWeightValue(color: .pink,score: 2,probability: 30),
        ColorWeightValue(color: .green,score: 5,probability: 15),
        ColorWeightValue(color: .blue,score: 8,probability: 10),
        ColorWeightValue(color: .black,score: 10,probability: 5)
    ]
    
    //logic to generate a weighted random color.

    static func weightedColor(input: [ColorWeightValue]) -> ColorWeightValue {

        let total = UInt32(input.map { $0.probability }.reduce(0, +))
        let rand = Int(arc4random_uniform(total))

        var sum = 0
        for eachInput in input {
            sum += eachInput.probability
            if rand < sum {
                return eachInput
            }
        }
        fatalError("This should never be reached")
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
                        .font(.title)
                    Spacer()
                    Label(String(startGame.numOfBubbles), systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.title)
                    Label(String(Int(startGame.gameTime)), systemImage: "")
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
                                //on click: remove the bubble from the list, append score.
                                //if previos bubble popped was same as this one, augment the score before popping.
                            }
                    }
                }
                .onAppear() {
                    //start the game logic
                    //generate bubbles into list after every 0.nth second?
                }
            }
        }
    }
}

//logic to start the game
//logic to generate bubbles
//logic to save score in highscoreviewmodel after timer expires
//logic to reset to main content view after timer expires

#Preview {
    StartGameView().environmentObject(StartGameViewModel())
}
