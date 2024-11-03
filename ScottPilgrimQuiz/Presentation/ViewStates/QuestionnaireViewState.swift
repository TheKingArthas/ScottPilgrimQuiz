//
//  QuestionnaireViewState.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

enum QuestionnaireViewState {
    case correctAnswer(score: Int)
    case error(_ title: String, _ description: String)
    case firstLoad
    case finished
    case highestScores
    case incorrectAnswer(correctAnswer: String)
    case loading
    case mainMenu
    case question(_ question: QuestionModel)
}
