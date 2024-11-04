//
//  ResultsView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct ScoresView: View {
    @StateObject private var viewModel: ScoresViewModel
    @State private var playerName: String
    private let playerScore: Int

    init(viewModel: ScoresViewModel, playerScore: Int) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _playerName = .init(initialValue: "")
        self.playerScore = playerScore
    }

    var body: some View {
        switch viewModel.viewState {
        case .loading:
            LoadingView()
                .onAppear {
                    viewModel.fetchHighestScores()
                    viewModel.viewState = .playerScore(isInTopScores: viewModel.isInTopScores(playerScore))
                }
        case let .playerScore(isInTopScores):
            playerScoreView(playerScore, isInTopScores: isInTopScores)
        case let .highestScores(highestScores):
            HighestScoresView(highestScores) {
                //TODO: Add action
            }
        case let .error(title, description):
            ErrorView(title: title, description: description)
        }
    }

    private func playerScoreView(_ score: Int, isInTopScores: Bool) -> some View {
        VStack {
            Text("Game over")
            Text("Your total score was")
            Text("\(score)")
            if isInTopScores {
                Text("Enter your name to save your score")
                TextField("Name", text: $playerName)
                saveScoreButtonView
                    .disabled(isInTopScores && playerName.isEmpty)
            }
        }
    }

    private var saveScoreButtonView: some View {
        Button {
            //TODO: Add action
        } label: {
            Text("Restart")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }
}

#Preview {
    ScoresView(viewModel: ScoresViewModel(scoreService: ScoreService()),
               playerScore: 99)
}
