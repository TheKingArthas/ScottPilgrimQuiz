//
//  ResultsView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct SaveScoreView: View {
    private let totalScore: Int
    private let saveScoreAction: (String) -> Void
    private var playerName: String

    init(totalScore: Int, saveScoreAction: @escaping (String) -> Void) {
        self.totalScore = totalScore
        self.saveScoreAction = saveScoreAction
        self.playerName = ""
    }

    var body: some View {
        VStack {
            scoreView
            saveScoreView
        }
    }

    private var scoreView: some View {
        VStack {
            Text("Game over")
            Text("Your total score was")
            Text("\(totalScore)")
            Text("Enter your name to save your score")
            TextField("Name", text: .constant(""))
        }
    }

    private var saveScoreView: some View {
        Button {
            saveScoreAction(playerName)
        } label: {
            Text("Restart")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }
}

#Preview {
    SaveScoreView(totalScore: 50) { _ in
        print("Restart button pressed.")
    }
}
