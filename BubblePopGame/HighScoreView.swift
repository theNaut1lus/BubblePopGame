//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 2/4/2024.
//

import SwiftUI

struct HighScoreView: View {
    @State var highScoreViewModel: HighScoreViewModel = HighScoreViewModel()
    
    var body: some View {
        VStack {
            Label("High Score View", systemImage: "")
            List {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

#Preview {
    HighScoreView()
}
