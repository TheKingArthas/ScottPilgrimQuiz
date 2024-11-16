//
//  HighestScoresView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct HighestScoresView: View {
    private let highestScores: [PlayerScoreModel]
    @Environment(\.dismiss) private var dismiss

    init(_ highestScores: [PlayerScoreModel]) {
        self.highestScores = highestScores.sorted().reversed()
    }

    var body: some View {
        mainView(highestScores)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                CustomColor.background
                    .ignoresSafeArea()
            }
    }

    private func mainView(_ highestScores: [PlayerScoreModel]) -> some View {
        VStack {
            titleView
                .padding(.vertical, LayoutMultiplier.padding(4))
            if highestScores.isEmpty {
                Text("No scores to show.")
                    .customModifierTextBody(CustomColor.white)
                    .padding(.horizontal, LayoutMultiplier.padding(4))
            } else {
                highestScoresTableView(highestScores)
                    .padding(.horizontal, LayoutMultiplier.padding(4))
            }
            Spacer()
            mainMenuButtonView
                .padding(.top, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(1))
        }
    }

    private var titleView: some View {
        Text("Highest scores")
            .customModifierTextH1()
    }

    private func playerScoreRowView(_ playerScore: PlayerScoreModel) -> some View {
        HStack {
            Text(playerScore.name)
            Spacer()
            Text("\(playerScore.score)")
        }
        .customModifierTextBody(CustomColor.white)
    }

    private var mainMenuButtonView: some View {
        PrimaryButton(labelText: "Main menu") { dismiss() }
    }

    private func highestScoresTableView(_ highestScores: [PlayerScoreModel]) -> some View {
        ScrollView {
            VStack {
                ForEach(highestScores, id: \.self) { score in
                    playerScoreRowView(score)
                        .padding(.vertical, LayoutMultiplier.padding(0.5))
                }
            }
        }
    }
}

#Preview {
    HighestScoresView([
        .init(name: "Federico", score: 100),
        .init(name: "Roxy", score: 200),
        .init(name: "Stacey", score: 300),
        .init(name: "Neil", score: 400),
        .init(name: "Knives", score: 500),
        .init(name: "Bryan Lee", score: 9999),
        .init(name: "Julie", score: 600),
        .init(name: "Envy", score: 700),
        .init(name: "Scott", score: 800),
        .init(name: "Ramona", score: 900)
    ])
}
