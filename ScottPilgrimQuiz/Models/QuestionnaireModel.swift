//
//  QuestionsModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 13/9/24.
//

import Foundation

struct QuestionnaireModel: Codable {
    let version: String
    let questions: [QuestionModel]
}
