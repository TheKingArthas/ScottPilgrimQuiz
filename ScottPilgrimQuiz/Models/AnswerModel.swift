//
//  AnswerModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

struct AnswerModel: Codable, Identifiable, Equatable {
    static func == (lhs: AnswerModel, rhs: AnswerModel) -> Bool {
        lhs.id == rhs.id
    }

    let id: String
    let description: String
}
