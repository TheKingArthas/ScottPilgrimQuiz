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
    private let nextButtonAction: () -> Void
    private let saveScoreButtonAction: (String) -> Void

    init(_ playerScore: Int,
         isInTopScores: Bool,
         nextButtonAction: @escaping () -> Void,
         saveScoreButtonAction: @escaping (String) -> Void) {
        _playerName = .init(initialValue: "")
        self.playerScore = playerScore
        self.isInTopScores = isInTopScores
        self.nextButtonAction = nextButtonAction
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

    var mainView: some View {
        VStack {
            Text("Game over")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
                .foregroundStyle(CustomColor.primary)
                .padding(.top, LayoutMultiplier.padding(12))
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("Your total score was")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                .foregroundStyle(CustomColor.primary)
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("\(playerScore)")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(10)))
                .foregroundStyle(playerScore > 0 ? CustomColor.positive : CustomColor.destructive)
            if isInTopScores {
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

    private var nextButtonView: some View {
        Button {
            //TODO: Add action
        } label: {
            Text("Restart")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }

    private func saveScoreButtonView(isDisabled: Bool) -> some View {
        Button {
            saveScoreButtonAction(playerName)
        } label: {
            Text("Save score")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(isDisabled ? CustomColor.disabled : CustomColor.positive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
        .disabled(isDisabled)
    }

    private func limitTextfieldText(_ upper: Int) {
        if playerName.count > upper {
            playerName = String(playerName.prefix(upper))
        }
    }
}

#Preview {
    PlayerScoreView(99,
                    isInTopScores: false,
                    nextButtonAction: {},
                    saveScoreButtonAction: {_ in })
}
