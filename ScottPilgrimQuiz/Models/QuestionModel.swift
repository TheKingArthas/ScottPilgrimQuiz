//
//  QuestionModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

struct QuestionModel: Codable, Identifiable {
    let id: String
    let question: String
    let correctAnswer: String
    let wrongAnswers: [String]
    var allAnswers: [String] {
        var allAnswers = Array(wrongAnswers)
        allAnswers.append(correctAnswer)
        return allAnswers
    }

    enum CodingKeys: String, CodingKey {
        case id
        case question
        case correctAnswer = "correct_answer"
        case wrongAnswers = "wrong_answers"
    }
}
