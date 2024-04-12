//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct HighScoreView: View {
    @EnvironmentObject var highScoreViewModel: HighScoreViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.titlePageBackground)
                .ignoresSafeArea()
            VStack {
                Label("High Score View", systemImage: "")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.black)
                    .foregroundStyle(.regularMaterial)
                List {
                    ForEach(highScoreViewModel.HighScores) { highScore in
                        Text("\(highScore.name): \(highScore.score)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.black)
                            .foregroundStyle(.mint)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
                .listStyle(.sidebar)
                Spacer()
            }
        }
    }
}

#Preview {
    HighScoreView().environmentObject(HighScoreViewModel())
}
