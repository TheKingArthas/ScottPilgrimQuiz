//
//  QuestionsModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 13/9/24.
//

import Foundation

struct QuestionsModel: Codable {
    let publicationDate: Date
    let questions: [QuestionModel]

    enum CodingKeys: String, CodingKey {
        case publicationDate = "publication_date"
        case questions
    }
}
