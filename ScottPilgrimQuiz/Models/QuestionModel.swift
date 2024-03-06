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
    let answers: [AnswerModel]
}

struct AnswerModel: Codable, Identifiable {
    let id: String
    let answer: String
    let isCorrect: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case answer
        case isCorrect = "is_Correct"
    }
}
