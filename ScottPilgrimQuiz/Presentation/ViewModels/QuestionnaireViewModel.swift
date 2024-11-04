//
//  QuizViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation
import SwiftUICore

class QuestionnaireViewModel: ObservableObject {
    @Published var viewState: QuestionnaireViewState
    private(set) var amountOfQuestions: Int
    private(set) var currentQuestion: QuestionModel?
    private(set) var currentQuestionNumber: Int
    private(set) var timerViewModel: TimerViewModel
    private(set) var playerScore: Int
    private var unaskedQuestions: [QuestionModel]
    private let questionsService: QuestionService

    init(amountOfQuestions: Int,
         questionsService: QuestionService,
         secondsToAnswerEachQuestion: Int) {
        self.viewState = .firstLoad
        self.amountOfQuestions = amountOfQuestions
        self.currentQuestionNumber = 0
        self.currentQuestion = nil
        self.unaskedQuestions = []
        self.questionsService = questionsService
        self.playerScore = 0
        self.timerViewModel = TimerViewModel(initialTime: secondsToAnswerEachQuestion)
    }

    func initQuestionnaire() throws {
        try fetchQuestions()
        popQuestion()
    }

    func answer(_ answer: String) {
        if let currentQuestion = currentQuestion {
            if currentQuestion.correctAnswer == answer {
                let answerScore = correctAnswerScore()
                addScore(answerScore)
                viewState = .correctAnswer(score: answerScore)
            } else {
                viewState = .incorrectAnswer(correctAnswer: currentQuestion.correctAnswer)
            }
        }
        timerViewModel.stopTimer()
    }

    func nextQuestion() {
        timerViewModel.stopTimer()
        if currentQuestionNumber < amountOfQuestions {
            popQuestion()
        } else {
            viewState = .finished(playerScore: playerScore)
        }
    }

    private func fetchQuestions() throws {
        var questions = try fetchAllQuestions()
        guard questions.count >= amountOfQuestions else { throw QuestionnaireViewModelError.notEnoughQuestionsFetched }

        (1...amountOfQuestions).forEach { _ in
            if let randomQuestion = popRandomQuestion(&questions) {
                unaskedQuestions.append(randomQuestion)
            }
        }
    }

    private func popQuestion() {
        currentQuestion = popRandomQuestion(&unaskedQuestions)
        if let currentQuestion = currentQuestion {
            currentQuestionNumber += 1
            viewState = .question(currentQuestion)
        }
        timerViewModel.startTimer()
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

    private func correctAnswerScore() -> Int {
        timerViewModel.remainingTime
    }

    private func addScore(_ score: Int) {
        self.playerScore += score
    }
}
