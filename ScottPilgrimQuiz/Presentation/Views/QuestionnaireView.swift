//
//  QuizView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionnaireView: View {
    @StateObject private var viewModel: QuestionnaireViewModel

    init(viewModel: QuestionnaireViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        switch viewModel.viewState {
        case .mainMenu:
            Text("Main menu")
        case .question(let currentQuestion):
            QuestionView(currentQuestionNumber: viewModel.currentQuestionNumber,
                         amountOfTotalQuestions: viewModel.amountOfQuestions,
                         currentQuestion: currentQuestion,
                         timer: viewModel.timerViewModel) { answer in
                viewModel.answer(answer)
            } skipQuestionAction: {
                viewModel.nextQuestion()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                CustomColor.background
            }
            .ignoresSafeArea()

        case .correctAnswer(let score):
            CorrectAnswerView(pointsEarned: score) { viewModel.nextQuestion() }
        case .incorrectAnswer(let correctAnswer):
            WrongAnswerView(correctAnswer: correctAnswer) { viewModel.nextQuestion() }
        case .loading:
            LoadingView()
        case .firstLoad:
            LoadingView()
                .onAppear {
                    do {
                        try viewModel.initQuestionnaire()
                    } catch {
                        viewModel.viewState = .error("Something went wrong:", error.localizedDescription)
                    }
                }
        case .error(let title, let description):
            ErrorView(title: title, description: description)
        case .finished:
            SaveScoreView(totalScore: viewModel.score) { playerName in
                viewModel.saveScore(playerName: playerName)
                viewModel.viewState = .highestScores
            }
        case .highestScores:
            EmptyView()
        }
    }
}
