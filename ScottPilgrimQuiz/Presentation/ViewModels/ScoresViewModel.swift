//
//  HighestScoresViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

enum ScoresViewState {
    case loading
    case highestScores(_ highestScores: [PlayerScoreModel])
    case playerScore(isInTopScores: Bool)
    case error(_ title: String, _ description: String)
}

class ScoresViewModel: ObservableObject {
    @Published var viewState: ScoresViewState
    private let scoreService: ScoreService
    private(set) var mainMenuAction: () -> Void

    init(scoreService: ScoreService) {
        self.viewState = .loading
        self.scoreService = scoreService
        self.mainMenuAction = {
            //TODO: Add nav
        }
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
}
