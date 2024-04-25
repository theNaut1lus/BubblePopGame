//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct HighScoreView: View {
    
    //Grabs the highscoreviewmodel env variable
    @EnvironmentObject var highScoreViewModel : HighScoreViewModel
    
    //initialise swift data model and grab stored highscore list
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \HighScoreList.score, order: .reverse) private var highScores: [HighScoreList]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            VStack {
                Label("High Scores", systemImage: "")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(.regularMaterial)
                //Swift Data list for high scores
                 NavigationStack {
                    List {
                        ForEach(highScores) {highScore in
                            HStack {
                                Image(systemName: "bolt")
                                Text(highScore.name)
                                Spacer()
                                Text(String(highScore.score))
                                Spacer()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    Spacer()
                }
            }
        }
        .onAppear() {
            //When navigating to this view from game view, then we will need to add the highscore to list.
            addToList(highScoreViewModel: highScoreViewModel)
        }
        .padding()
    }
    
    func addToList(highScoreViewModel: HighScoreViewModel) {
        //scenario where highscore view is reached directly from the main view
        if highScoreViewModel.name == "" {
            //do nothing, empty env object.
            return
        }
        else {
            //fetch data from highscoreviewmodel using swift UI
            //sort by highest score.
            modelContext.insert(HighScoreList(name: highScoreViewModel.name, score: highScoreViewModel.score))
            //reset the highScoreViewModel env object
            highScoreViewModel.name = ""
            highScoreViewModel.score = 0.0
        }
        
    }
}

//to make preview behave well with with Swift Data
#Preview {
    
    let container = try! ModelContainer(for: HighScoreList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    
    let model = HighScoreList(name: "Sid", score: 832)
    context.insert(model)
    try! context.save()
        
    return HighScoreView()
        .environmentObject(HighScoreViewModel())
        .environmentObject(StartGameViewModel())
        .modelContainer(container)
}
