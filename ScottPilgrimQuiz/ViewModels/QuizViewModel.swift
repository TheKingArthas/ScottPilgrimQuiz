//
//  QuizViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

enum QuizViewModelError: Error {
    case notEnoughQuestionsFetched
}

class QuizViewModel: ObservableObject {
    let amountOfRandomQuestions: Int
    @Published private var unaskedQuestions: [QuestionModel]
    
    init(amountOfRandomQuestions: Int) {
        self.amountOfRandomQuestions = amountOfRandomQuestions
        self.unaskedQuestions = []
    }
    
    func fetchQuestions() throws {
        try fetchRandomQuestions(amount: amountOfRandomQuestions)
    }
    
    func popRandomQuestion() -> QuestionModel? {
        guard !unaskedQuestions.isEmpty else {
            return nil
        }
        
        let randomPosition = Int.random(in: 0...unaskedQuestions.count - 1)
        let question = unaskedQuestions[randomPosition]
        unaskedQuestions.remove(at: randomPosition)
        
        return question
    }
    
    private func fetchRandomQuestions(amount amountOfQuestions: Int) throws {
        var questions = try fetchAllQuestions()
        
        guard questions.count >= amountOfQuestions else {
            throw QuizViewModelError.notEnoughQuestionsFetched
        }
        
        (1...amountOfQuestions).forEach { _ in
            if let randomQuestion = popRandomQuestion() {
                unaskedQuestions.append(randomQuestion)
            }
        }
    }
    
    private func fetchAllQuestions() throws -> [QuestionModel] {
        return try QuestionService().fetchQuestions()
    }
}
