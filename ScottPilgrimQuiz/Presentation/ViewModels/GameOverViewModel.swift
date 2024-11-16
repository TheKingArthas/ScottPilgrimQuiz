//
//  HighestScoresViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

class GameOverViewModel: ObservableObject {
    @Published var viewState: GameOverViewState
    private let scoreService: ScoreService

    init(scoreService: ScoreService) {
        self.viewState = .loading
        self.scoreService = scoreService
    }

    func fetchHighestScores() {
        do {
            try scoreService.fetchHighestScores()
            viewState = .highestScores(scoreService.highestScores)
        } catch {
            viewState = .error("Highest scores error", error.localizedDescription)
        }
    }

    func isInTopScores(_ score: Int) -> Bool {
        scoreService.isInTopScores(score)
    }

    func saveScore(playerName: String, score: Int) {
        let playerScore = PlayerScoreModel(name: playerName, score: score)
        do {
            try scoreService.saveScore(playerScore)
            fetchHighestScores()
            viewState = .highestScores(scoreService.highestScores)
        } catch {
            print("Failed to save score: \(error.localizedDescription)")
        }
    }
}
