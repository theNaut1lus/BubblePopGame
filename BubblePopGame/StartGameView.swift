//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct StartGameView: View {
    @State private var bubbles = [Bubble]()
    @State private var prevBubble = Bubble(position: CGPoint(x: 0, y: 0), creationTime: Date())
    @State private var score = 0.0
    let bubbleSize: CGFloat = 50
    
    //to animate the timer
    @State private var progress = 1.0
    
    //To display the highest score at the bottom
    @Query(sort: \HighScoreList.score, order: .reverse) private var highScores: [HighScoreList]
    
    //game settings environment variables
    @EnvironmentObject var startGameViewModel : StartGameViewModel
    @EnvironmentObject var highScoreViewModel : HighScoreViewModel

    @State var shouldNavigate = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack {
                        Text("Player")
                            .fontWeight(.heavy)
                            .foregroundStyle(.link)
                        Label(startGameViewModel.name, systemImage: "")
                            .foregroundStyle(.regularMaterial)
                            .fontWeight(.black)
                            .font(.title)
                    }
                    .padding(.leading, 20.0)
                    VStack {
                        Text("Score")
                            .fontWeight(.heavy)
                            .foregroundStyle(.link)
                        Label(String(score), systemImage: "")
                            .foregroundStyle(.regularMaterial)
                            .fontWeight(.black)
                            .font(.title)
                    }
                    .padding(.leading, 20.0)
                    Spacer()
                    ZStack {
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color.pink, lineWidth: 2)
                            .frame(width: 70, height: 70)
                            .padding(.leading, 5.0)
                        Label(String(Int(startGameViewModel.gameTime)), systemImage: "")
                            .foregroundStyle(.regularMaterial)
                            .fontWeight(.black)
                            .font(.title)
                            .onReceive(timer, perform: { _ in
                                if startGameViewModel.gameTime > 0 {
                                    startGameViewModel.gameTime -= 1
                                    progress = progress - progress/startGameViewModel.gameTime
                                }
                                else {
                                    timer.upstream.connect().cancel()
                                    shouldNavigate = true
                                }
                                
                            })
                    }
                    .padding(.trailing, 20.0)
                    
                }
                Spacer()
                ZStack {
                    ForEach(bubbles) {bubble in
                        Circle()
                            .foregroundStyle(bubble.colorWeightValue.color)
                            .frame(width: bubbleSize, height: bubbleSize)
                            .position(bubble.position)
                            .onAppear{
                                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                                    // do some pulsing animation
                                }
                            }
                            .onTapGesture {
                                //pop bubble logic
                                popBubble(bubble, prevBubble)
                            }
                    }
                }
                .onReceive(timer, perform: { _ in
                    if startGameViewModel.gameTime > startGameViewModel.numOfBubbles {
                        generateBubble()
                    }
                    else {
                        //game ended: save name and score to highScoreViewModel
                        highScoreViewModel.name = startGameViewModel.name
                        highScoreViewModel.score = score
                        //logic to push to highscoreview after game timer ends and sending the name and final score to highscoreviewmodel for storing.
                    }
                })
                Spacer()
                HStack {
                    VStack {
                        Text("Current High Score")
                            .foregroundStyle(.regularMaterial)
                            .fontWeight(.black)
                            .font(.subheadline)
                        HStack {
                            Text(String(highScores.first?.name ?? "name"))
                                .foregroundStyle(.regularMaterial)
                                .fontWeight(.semibold)
                                .font(.footnote)
                            Text(String(highScores.first?.score ?? 0.0))
                                .foregroundStyle(.regularMaterial)
                                .fontWeight(.semibold)
                                .font(.footnote)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: HighScoreView()
                        .environmentObject(highScoreViewModel)
                        .environmentObject(startGameViewModel), label: {Text("View High Scores")})
                    .disabled(!shouldNavigate)
                }
                .padding(20)
            }
        }
    }
    
    //logic to generate bubbles, from 1 to max value inputted from settings
    //TODO: fix overlap of bubbles
    func generateBubble() {
        
        let randomX = CGFloat.random(in: 2*bubbleSize...(UIScreen.main.bounds.width - 2*(bubbleSize)))
        let randomY = CGFloat.random(in: 3*bubbleSize...(UIScreen.main.bounds.height - 2*(bubbleSize)))
        let bubble = Bubble(position: CGPoint(x: randomX, y: randomY), creationTime: Date())
        bubbles.append(bubble)
        
        //logic to remove bubbles after max number is reached as entered by the user
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

//use swift data to persist game highscore and name


#Preview {
    let container = try! ModelContainer(for: HighScoreList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    
    let model = HighScoreList(name: "Sid", score: 832)
    context.insert(model)
    try! context.save()
    return StartGameView()
        .environmentObject(StartGameViewModel())
        .environmentObject(HighScoreViewModel())
        .modelContainer(container)
}
