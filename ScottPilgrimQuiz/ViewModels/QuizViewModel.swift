//
//  QuizViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published private var questions: [QuestionModel] = []
    private var unaskedQuestions: [QuestionModel] = []
    
    func fetchQuestions() throws {
        questions = try QuestionService().fetchQuestions()
        resetUnaskedQuestions()
    }
    
    func popRandomUnaskedQuestion() -> QuestionModel? {
        guard !unaskedQuestions.isEmpty else {
            return nil
        }
        
        let questionPosition = Int.random(in: 0...unaskedQuestions.count - 1)
        let unaskedQuestion = unaskedQuestions[questionPosition]
        unaskedQuestions.remove(at: questionPosition)
        
        return unaskedQuestion
    }
    
    func resetUnaskedQuestions() {
        unaskedQuestions = questions
    }
}
