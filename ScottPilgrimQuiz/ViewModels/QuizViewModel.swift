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
    let amountOfQuestions: Int
    var currentQuestionNumber: Int
    private var unaskedQuestions: [QuestionModel]
    private let questionsService: QuestionService

    init(amountOfQuestions: Int,
         questionsService: QuestionService) {
        self.amountOfQuestions = amountOfQuestions
        self.currentQuestionNumber = 0
        self.unaskedQuestions = []
        self.questionsService = questionsService
    }

    func fetchQuestions() throws {
        var questions = try fetchAllQuestions()
        guard questions.count >= amountOfQuestions else { throw QuizViewModelError.notEnoughQuestionsFetched }

        (1...amountOfQuestions).forEach { _ in
            if let randomQuestion = popRandomQuestion(&questions) {
                unaskedQuestions.append(randomQuestion)
            }
        }
    }

    func popQuestion() -> QuestionModel? {
        currentQuestionNumber += 1
        return popRandomQuestion(&unaskedQuestions)
    }

    private func popRandomQuestion(_ questions: inout [QuestionModel]) -> QuestionModel? {
        guard !questions.isEmpty else { return nil }

        let randomPosition = Int.random(in: 0...questions.count - 1)
        let question = questions[randomPosition]
        questions.remove(at: randomPosition)

        return question
    }

    private func fetchAllQuestions() throws -> [QuestionModel] {
        return try QuestionService().fetchQuestions()
    }
}
