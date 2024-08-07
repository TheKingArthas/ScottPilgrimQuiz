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
        popQuestion(&unaskedQuestions)
    }
    
    private func popQuestion(_ questions: inout [QuestionModel]) -> QuestionModel? {
        guard !questions.isEmpty else {
            return nil
        }
        
        let randomPosition = Int.random(in: 0...questions.count - 1)
        let question = questions[randomPosition]
        questions.remove(at: randomPosition)
        
        return question
    }
    
    private func fetchRandomQuestions(amount amountOfQuestions: Int) throws {
        var questions = try fetchAllQuestions()
        
        guard questions.count >= amountOfQuestions else {
            throw QuizViewModelError.notEnoughQuestionsFetched
        }
        
        (1...amountOfQuestions).forEach { _ in
            if let randomQuestion = popQuestion(&questions) {
                unaskedQuestions.append(randomQuestion)
            }
        }
    }
    
    private func fetchAllQuestions() throws -> [QuestionModel] {
        return try QuestionService().fetchQuestions()
    }
}
