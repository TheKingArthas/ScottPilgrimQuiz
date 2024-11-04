//
//  ResultsView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct ScoresView: View {
    @StateObject private var viewModel: ScoresViewModel
    private let playerScore: Int

    init(viewModel: ScoresViewModel, playerScore: Int) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
            PlayerScoreView(playerScore,
                            isInTopScores: isInTopScores) {
                viewModel.goToMainMenu()
            } saveScoreButtonAction: { playerName in
                viewModel.saveScore(playerName: playerName, score: playerScore)
                viewModel.viewState = .highestScores(viewModel.highestScores)
            }
        case let .highestScores(highestScores):
            HighestScoresView(highestScores) {
                viewModel.goToMainMenu()
            }
        case let .error(title, description):
            ErrorView(title: title, description: description) { viewModel.goToMainMenu() }
        }
    }
}

#Preview {
    ScoresView(viewModel: ScoresViewModel(scoreService: ScoreService()),
               playerScore: 99)
}
