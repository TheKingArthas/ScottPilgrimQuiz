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
    @Published private var unaskedQuestions: [QuestionModel]
    private let questionsService: QuestionService

    init(amountOfQuestions: Int, questionsService: QuestionService) {
        self.amountOfQuestions = amountOfQuestions
        self.unaskedQuestions = []
        self.questionsService = questionsService
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

    func fetchQuestions() throws {
        let questions = try fetchAllQuestions()

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
