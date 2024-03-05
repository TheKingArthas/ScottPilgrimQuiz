//
//  QuestionModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

struct QuestionModel: Codable {
    let question: String
    let correctAnswer: String
    let wrongAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case wrongAnswers = "wrong_answers"
    }
}
