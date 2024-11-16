//
//  QuestionnaireViewState.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

enum QuestionnaireViewState {
    case correctAnswer(score: Int)
    case error(_ title: String, _ description: String)
    case finished(playerScore: Int)
    case firstLoad
    case loading
    case question(_ question: QuestionModel)
    case questionnaireCountdown
    case timeIsUp
    case wrongAnswer(correctAnswer: String)
}
