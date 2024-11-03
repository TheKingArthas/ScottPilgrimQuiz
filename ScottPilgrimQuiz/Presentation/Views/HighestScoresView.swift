//
//  HighestScoresView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct HighestScoresView: View {
    private let highestScores: [PlayerScore]
    private let mainMenuAction: () -> Void

    init(_ highestScores: [PlayerScore], mainMenuAction: @escaping () -> Void) {
        self.highestScores = highestScores.sorted().reversed()
        self.mainMenuAction = mainMenuAction
    }

    var body: some View {
        VStack {
            title
            ScrollView {
                VStack {
                    ForEach(highestScores, id: \.self) { score in
                        Text("\(score.name): \(score.score)")
                    }
                }
            }
            Spacer()
            mainMenuButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            CustomColor.background
        }
        .ignoresSafeArea()
    }

    private var title: some View {
        Text("Highest scores")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
            .foregroundStyle(CustomColor.primary)
    }

    private var mainMenuButton: some View {
        Button {
            mainMenuAction()
        } label: { Text("Main Menu")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.primary)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }
}

#Preview {
    HighestScoresView([
        PlayerScore(name: "Federico", score: 100),
        PlayerScore(name: "Roxy", score: 200),
        PlayerScore(name: "Stacey", score: 300),
        PlayerScore(name: "Neil", score: 400),
        PlayerScore(name: "Knives", score: 500),
        PlayerScore(name: "Bryan Lee", score: 9999),
        PlayerScore(name: "Julie", score: 600),
        PlayerScore(name: "Envy", score: 700),
        PlayerScore(name: "Scott", score: 800),
        PlayerScore(name: "Ramona", score: 900)
    ]) {
        print("Main menu button pressed")
    }
}
