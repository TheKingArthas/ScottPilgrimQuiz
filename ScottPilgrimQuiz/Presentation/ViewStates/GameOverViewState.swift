//
//  ScoresViewState.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

enum GameOverViewState {
    case loading
    case highestScores(_ highestScores: [PlayerScoreModel])
    case playerScore(isInTopScores: Bool)
    case error(_ title: String, _ description: String)
}
