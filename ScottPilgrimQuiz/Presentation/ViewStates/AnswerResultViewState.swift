//
//  QuestionResultViewState.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 16/11/24.
//

import Foundation

enum AnswerResultViewState {
    case correctAnswer(score: Int, isLastQuestion: Bool)
    case wrongAnswer(correctAnswer: String, isLastQuestion: Bool)
    case timeIsUp(isLastQuestion: Bool)
}
