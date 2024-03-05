//
//  QuizViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [QuestionModel] = []
    
    func fetchQuestions() throws {
        questions = try QuestionService().fetchQuestions()
    }
}
