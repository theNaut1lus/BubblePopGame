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
    let score: Double
    let probability: Int
}

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let position: CGPoint
//    let color: Color
//    let scoreValue: Int
    var colorWeightValue = ColorWeightValue(color: .brown, score: 100, probability: 0) //a default value that should never occur.
    let creationTime: Date
    let colorList: [ColorWeightValue] = [
        ColorWeightValue(color: .red,score: 1,probability: 40),
        ColorWeightValue(color: .pink,score: 2,probability: 30),
        ColorWeightValue(color: .green,score: 5,probability: 15),
        ColorWeightValue(color: .blue,score: 8,probability: 10),
        ColorWeightValue(color: .black,score: 10,probability: 5)
    ]
    
    //logic to generate a weighted random color.
    
    init(position: CGPoint, creationTime: Date) {
        self.position = position
//        self.colorWeightValue = colorWeightValue
        self.creationTime = creationTime
        self.colorWeightValue = weightedColor(input: colorList)
    }

    func weightedColor(input: [ColorWeightValue]) -> ColorWeightValue {

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
    @State private var prevBubble = Bubble(position: CGPoint(x: 0, y: 0), creationTime: Date())
    @State private var score = 0.0
    let bubbleSize: CGFloat = 75
    
    @EnvironmentObject var startGameViewModel : StartGameViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Label(startGameViewModel.name, systemImage: "")
                        .padding(.leading, 20.0)
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.title)
                    Label(String(score), systemImage: "")
                        .padding(.leading, 20.0)
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.title)
                    Spacer()
                    Label(String(startGameViewModel.numOfBubbles), systemImage: "")
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(.title)
                    Label(String(Int(startGameViewModel.gameTime)), systemImage: "")
                        .padding(.trailing, 20.0)
                        .foregroundStyle(.regularMaterial)
                        .fontWeight(.black)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .onReceive(timer, perform: { _ in
                            if startGameViewModel.gameTime > 0 {
                                startGameViewModel.gameTime -= 1
                            }
                                    
                        })
                    
                }
                Spacer()
                ZStack {
                    ForEach(bubbles) {bubble in
                        Circle()
                            .foregroundStyle(bubble.colorWeightValue.color)
                            .frame(width: bubbleSize, height: bubbleSize)
                            .position(bubble.position)
                            .onTapGesture {
                                //pop bubble logic
                                popBubble(bubble, prevBubble)
                            }
                    }
                }
                .onReceive(timer, perform: { _ in
                    if startGameViewModel.gameTime > 0 {
                        generateBubble()
                    }
                    else {
                        //logic to save score in highscoreviewmodel after timer expires
                        //logic to reset to main content view after timer expires
                        //logic to push to highscoreview after game timer ends and sending the name and final score to highscoreviewmodel for storing.
                    }
                })
            }
        }
    }
    
    //logic to generate bubbles, from 1 to max value inputted from settings
    func generateBubble() {
        let randomX = CGFloat.random(in: 0...(UIScreen.main.bounds.width - 3*(bubbleSize)))
        let randomY = CGFloat.random(in: 0...(UIScreen.main.bounds.height - 3*(bubbleSize)))
        let bubble = Bubble(position: CGPoint(x: randomX, y: randomY), creationTime: Date())
        bubbles.append(bubble)
        
        //logic to refresh bubbles after max number is reached as entered by the user
        DispatchQueue.main.asyncAfter(deadline: .now() + startGameViewModel.numOfBubbles) {
            //remove bubble
            removeBubble(bubble)
        }
    }
    
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(of: bubble) {
            bubbles.remove(at: index)
        }
    }
    
    func popBubble(_ bubble: Bubble, _ previousBubble: Bubble) {
        var bubbleScore = bubble.colorWeightValue.score
        //if previous bubble popped was same as this one, augment the score before popping.
        if prevBubble.colorWeightValue.color == bubble.colorWeightValue.color {
            bubbleScore = 1.5*bubble.colorWeightValue.score
        }
        if let index = bubbles.firstIndex(of: bubble) {
            bubbles.remove(at: index)
            score += bubbleScore
        }
        prevBubble = bubble
    }
}

#Preview {
    StartGameView().environmentObject(StartGameViewModel())
}
