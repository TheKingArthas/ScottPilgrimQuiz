//
//  HighestScoresView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct HighestScoresView: View {
    private let highestScores: [PlayerScoreModel]
    private let mainMenuButtonAction: () -> Void

    init(_ highestScores: [PlayerScoreModel],
         mainMenuButtonAction: @escaping () -> Void) {
        self.highestScores = highestScores.sorted().reversed()
        self.mainMenuButtonAction = mainMenuButtonAction
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
            title
                .padding(.vertical, LayoutMultiplier.padding(4))
            ScrollView {
                VStack {
                    ForEach(highestScores, id: \.self) { score in
                        playerScoreRow(score)
                            .padding(.vertical, LayoutMultiplier.padding(0.5))
                    }
                }
                .padding(.horizontal, LayoutMultiplier.padding(4))
            }
            Spacer()
            mainMenuButton
                .padding(.top, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(1))
        }
    }

    private var title: some View {
        Text("Highest scores")
            .customModifierTextH1()
    }

    private func playerScoreRow(_ playerScore: PlayerScoreModel) -> some View {
        HStack {
            Text(playerScore.name)
            Spacer()
            Text("\(playerScore.score)")
        }
        .customModifierTextH3(CustomColor.white)
    }

    private var mainMenuButton: some View {
        PrimaryButton(labelText: "Main menu") { mainMenuButtonAction() }
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
    ]) {
        print("Main menu button pressed")
    }
}
