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
    private let saveScoreButtonAction: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    init(_ playerScore: Int,
         isInTopScores: Bool,
         saveScoreButtonAction: @escaping (String) -> Void) {
        _playerName = .init(initialValue: "")
        self.playerScore = playerScore
        self.isInTopScores = isInTopScores
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
                .padding(.bottom, LayoutMultiplier.padding(8))
            totalScoreTextView
            scoreView(playerScore)
                .padding(.top, LayoutMultiplier.padding(1))
                .padding(.bottom, LayoutMultiplier.padding(7))
            //            if isInTopScores {
            if true {
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
            .customModifierTextH1()
    }

    private var totalScoreTextView: some View {
        Text("Your total score was")
            .customModifierTextH3()
    }

    private var nextButtonView: some View {
        PrimaryButton(labelText: "Restart", labelColor: CustomColor.destructive) { dismiss() }
    }

    private var saveScoreView: some View {
        VStack {
            Text("Enter your name")
                .customModifierTextH3()
                .padding(.top, LayoutMultiplier.padding(2))
            TextField("", text: $playerName, prompt:
                        Text("Name")
                .foregroundColor(CustomColor.disabled)
            )
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
            .frame(height: LayoutMultiplier.size(7))
            .multilineTextAlignment(.center)
            .foregroundStyle(CustomColor.white)
            .background {
                CustomColor.black
            }
            .cornerRadius(8)
            .padding(.horizontal, LayoutMultiplier.padding(5))
            .onReceive(Just(playerName)) { _ in limitTextfieldText(12) }
            Spacer()
            saveScoreButtonView(isDisabled: isInTopScores && playerName.isEmpty)
        }
    }

    private func scoreView(_ playerScore: Int) -> some View {
        Text("\(playerScore)")
            .customModifierTextScore(playerScore > 0 ? CustomColor.positive : CustomColor.destructive)
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
                    saveScoreButtonAction: {_ in })
}
