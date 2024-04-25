//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct HighScoreView: View {
    
    @EnvironmentObject var highScoreViewModel : HighScoreViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \HighScoreList.score, order: .reverse) private var highScores: [HighScoreList]
    
    @State var name: String = ""
    @State var score: String = ""
    
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
            addToList(highScoreViewModel: highScoreViewModel)
        }
        .padding()
    }
    
    func addToList(highScoreViewModel: HighScoreViewModel) {
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
