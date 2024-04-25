//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct StartGameView: View {
    
    //list of active bubbles at any time during the entire game state
    @State private var bubbles = [Bubble]()
    
    //saves the last bubble popped for score augmentation if consecutive tap
    @State private var prevBubble = Bubble(position: CGPoint(x: 0, y: 0), creationTime: Date())
    
    //maintain game score
    @State private var score = 0.0
    
    //bubble size to create the circle object
    let bubbleSize: CGFloat = 50
    
    //to animate the timer bar
    @State private var progress = 1.0
    
    //To display the highest score at the bottom
    @Query(sort: \HighScoreList.score, order: .reverse) private var highScores: [HighScoreList]
    
    //game settings and high score environment variables
    @EnvironmentObject var startGameViewModel : StartGameViewModel
    @EnvironmentObject var highScoreViewModel : HighScoreViewModel
    
    //to activate the high score view navigation after game ends.
    @State var shouldNavigate = false
    
    //main timer that controls game clock, bubble generation, high score finalisation.
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
                    //Bubbles created here in this forearch using the bubbles state list.
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
                                //pop bubble on tap and do necessary calculations
                                popBubble(bubble, prevBubble)
                            }
                    }
                }
                .onReceive(timer, perform: { _ in
                    //start the game, run timer, generate bubbles
                    if startGameViewModel.gameTime > startGameViewModel.numOfBubbles {
                        generateBubble()
                    }
                    else {
                        //game ended: save name and score to highScoreViewModel
                        highScoreViewModel.name = startGameViewModel.name
                        highScoreViewModel.score = score
                    }
                })
                Spacer()
                HStack {
                    VStack {
                        //Display the highes score in swift data highscore listS
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
    func generateBubble() {
        
        let randomX = CGFloat.random(in: 2*bubbleSize...(UIScreen.main.bounds.width - 2*(bubbleSize)))
        let randomY = CGFloat.random(in: 3*bubbleSize...(UIScreen.main.bounds.height - 2*(bubbleSize)))
        let bubble = Bubble(position: CGPoint(x: randomX, y: randomY), creationTime: Date())
        bubbles.append(bubble)
        
        //Remove bubbles from bubble array if max number is reached as entered by the user
        DispatchQueue.main.asyncAfter(deadline: .now() + startGameViewModel.numOfBubbles) {
            //remove bubble
            removeBubble(bubble)
        }
    }
    
    //this function removes the bubble when it expires, no user tap.
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(of: bubble) {
            bubbles.remove(at: index)
        }
    }
    
    //this function removes the bubble on user tap, performs all necessary calculations.
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

//to make preview behave well with with Swift Data
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
