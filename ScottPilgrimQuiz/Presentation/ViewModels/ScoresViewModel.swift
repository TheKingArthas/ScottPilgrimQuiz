//
//  HighestScoresViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

class ScoresViewModel: ObservableObject {
    @Published var viewState: ScoresViewState
    private let scoreService: ScoreService
    var highestScores: [PlayerScoreModel] { scoreService.highestScores }

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
        } catch {
            print("Failed to save score: \(error.localizedDescription)")
        }
    }
}
