//
//  QuizViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation
import SwiftUICore

enum QuestionnaireViewModelError: Error {
    case notEnoughQuestionsFetched
}

class QuestionnaireViewModel: ObservableObject {
    let amountOfQuestions: Int
    var currentQuestionNumber: Int
    @Published var currentQuestion: QuestionModel?
    private(set) var score: Int
    @State private(set) var timerViewModel: TimerViewModel
    private var unaskedQuestions: [QuestionModel]
    private let questionsService: QuestionService

    init(amountOfQuestions: Int,
         questionsService: QuestionService,
         secondsToAnswerEachQuestion: Int) {
        self.amountOfQuestions = amountOfQuestions
        self.currentQuestionNumber = 0
        self.currentQuestion = nil
        self.unaskedQuestions = []
        self.questionsService = questionsService
        self.score = 0
        self.timerViewModel = TimerViewModel(initialTime: secondsToAnswerEachQuestion)
    }

    func fetchQuestions() throws {
        var questions = try fetchAllQuestions()
        guard questions.count >= amountOfQuestions else { throw QuestionnaireViewModelError.notEnoughQuestionsFetched }

        (1...amountOfQuestions).forEach { _ in
            if let randomQuestion = popRandomQuestion(&questions) {
                unaskedQuestions.append(randomQuestion)
            }
        }
    }

    func popQuestion() {
        currentQuestionNumber += 1
        currentQuestion = popRandomQuestion(&unaskedQuestions)
    }

    func answer(_ answer: String) {
        if currentQuestion?.correctAnswer == answer {
            scoreCorrectAnswer()
        } else {
            print("False")
        }
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

    private func scoreCorrectAnswer() {
        score += timerViewModel.remainingTime
        print("Score: \(score)")
    }
}
