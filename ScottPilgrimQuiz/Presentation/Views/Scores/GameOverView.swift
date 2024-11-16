//
//  ResultsView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct GameOverView: View {
    @StateObject private var viewModel: GameOverViewModel
    private let playerScore: Int?

    init(viewModel: GameOverViewModel, playerScore: Int? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.playerScore = playerScore
    }

    var body: some View {
        switch viewModel.viewState {
        case .loading:
            LoadingView()
                .onAppear {
                    viewModel.fetchHighestScores()
                    if let playerScore = playerScore {
                        viewModel.viewState = .playerScore(isInTopScores: viewModel.isInTopScores(playerScore))
                    } else {
                        viewModel.fetchHighestScores()
                    }
                }
        case let .playerScore(isInTopScores):
            if let playerScore = playerScore {
                PlayerScoreView(playerScore,
                                isInTopScores: isInTopScores,
                                saveScoreButtonAction: { playerName in
                    viewModel.saveScore(playerName: playerName, score: playerScore)
                })
            }
        case let .highestScores(highestScores):
            HighestScoresView(highestScores)
        case let .error(title, description):
            ErrorView(title: title, description: description)
        }
    }
}

#Preview {
    GameOverView(viewModel: GameOverViewModel(scoreService: ScoreService()),
                 playerScore: 99)
}
