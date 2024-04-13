//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI
import SwiftData

struct HighScoreView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var highScores: [HighScoreViewModel]
    
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
                        modelContext.insert(HighScoreViewModel(name: name, score: Double(score) ?? 0.0))
                    } label: {
                        Image(systemName: "hare")
                    }
                }
            }
        }
        .padding()
    }
}

struct editView: View {
    @State var highScore: HighScoreViewModel
    var body: some View {
        TextField("Edit", text: $highScore.name)
    }
}

//fetch data from highscoreviewmodel using swift UI
//sort by highest score.

#Preview {
    HighScoreView()
        .modelContainer(for: HighScoreViewModel.self, inMemory: true)
}
