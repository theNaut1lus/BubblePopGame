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
    @Query private var highScores: [HighScoreList]
    
    @State var name: String = ""
    @State var score: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            Label("High Score View", systemImage: "")
                .font(.title)
                .fontWeight(.black)
                .foregroundStyle(.regularMaterial)
            VStack {
                 NavigationStack {
                    List {
                        ForEach(highScores) {highScore in
                            HStack {
                                Image(systemName: "bolt")
                                Text(highScore.name)
                                Spacer()
                                Text(String(highScore.score))
                                Spacer()
                                NavigationLink {
                                    editView(highScore: highScore)
                                } label: {
                                    Text("Edit")
                                }
                                Button {
                                    modelContext.delete(highScore)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .listStyle(.sidebar)
                    Spacer()
                }
                HStack {
                    TextField("Enter the name", text: $name)
                    TextField("Enter the score", text: $score)
                    Button {
                        modelContext.insert(HighScoreList(name: name, score: Double(score) ?? 0.0))
                    } label: {
                        Image(systemName: "hare")
                    }
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
            print("Env object: \(highScoreViewModel.id)  : \(highScoreViewModel.name) : \(highScoreViewModel.score)")
            modelContext.insert(HighScoreList(name: highScoreViewModel.name, score: highScoreViewModel.score))
        }
        
    }
}

struct editView: View {
    @State var highScore: HighScoreList
    var body: some View {
        TextField("Edit", text: $highScore.name)
    }
}

//fetch data from highscoreviewmodel using swift UI
//sort by highest score.

#Preview {
    HighScoreView()
        .environmentObject(HighScoreViewModel())
        .environmentObject(StartGameViewModel())
        .modelContainer(for: HighScoreList.self, inMemory: true)
}
