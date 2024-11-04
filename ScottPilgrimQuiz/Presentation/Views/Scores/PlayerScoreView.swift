//
//  PlayerScoreView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import Combine
import SwiftUI

struct PlayerScoreView: View {
    @State private var playerName: String
    private let playerScore: Int
    private let isInTopScores: Bool
    private let restartButtonAction: () -> Void
    private let saveScoreButtonAction: (String) -> Void

    init(_ playerScore: Int,
         isInTopScores: Bool,
         restartButtonAction: @escaping () -> Void,
         saveScoreButtonAction: @escaping (String) -> Void) {
        _playerName = .init(initialValue: "")
        self.playerScore = playerScore
        self.isInTopScores = isInTopScores
        self.restartButtonAction = restartButtonAction
        self.saveScoreButtonAction = saveScoreButtonAction
    }

    var body: some View {
        mainView
            .background {
                CustomColor.background
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
    }

    private var mainView: some View {
        VStack {
            titleView
                .padding(.top, LayoutMultiplier.padding(12))
                .padding(.bottom, LayoutMultiplier.padding(2))
            totalScoreTextView
                .padding(.bottom, LayoutMultiplier.padding(2))
            scoreView(playerScore)
            if isInTopScores {
                saveScoreView
                    .padding(.bottom, LayoutMultiplier.padding(4))
            } else {
                Spacer()
                nextButtonView
                    .padding(.bottom, LayoutMultiplier.padding(4))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, LayoutMultiplier.padding(2))
    }

    private var titleView: some View {
        Text("Game over")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
            .foregroundStyle(CustomColor.primary)
    }

    private var totalScoreTextView: some View {
        Text("Your total score was")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
            .foregroundStyle(CustomColor.primary)
    }

    private var nextButtonView: some View {
        PrimaryButton(labelText: "Restart", labelColor: CustomColor.destructive) { restartButtonAction() }
    }

    private var saveScoreView: some View {
        VStack {
            Text("Enter your name")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
                .foregroundStyle(CustomColor.primary)
                .padding(.top, LayoutMultiplier.padding(2))
            TextField("Name", text: $playerName)
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
                .foregroundStyle(CustomColor.white)
                .background()
                .padding(.top, LayoutMultiplier.padding(2))
                .padding(.horizontal, LayoutMultiplier.padding(5))
                .onReceive(Just(playerName)) { _ in limitTextfieldText(12) }
            Spacer()
            saveScoreButtonView(isDisabled: isInTopScores && playerName.isEmpty)
        }
    }

    private func scoreView(_ playerScore: Int) -> some View {
        Text("\(playerScore)")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(10)))
            .foregroundStyle(playerScore > 0 ? CustomColor.positive : CustomColor.destructive)
    }

    private func saveScoreButtonView(isDisabled: Bool) -> some View {
        PrimaryButton(labelText: "Save score",
                      labelColor: CustomColor.positive,
                      buttonAction: { saveScoreButtonAction(playerName) },
                      isDisabled: isDisabled)
    }
}

extension PlayerScoreView {
    private func limitTextfieldText(_ upper: Int) {
        if playerName.count > upper {
            playerName = String(playerName.prefix(upper))
        }
    }
}

#Preview {
    PlayerScoreView(99,
                    isInTopScores: false,
                    restartButtonAction: {},
                    saveScoreButtonAction: {_ in })
}
