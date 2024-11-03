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
            .onAppear() {
                viewModel.timerViewModel.startTimer()
            }
        case .correctAnswer(let score):
            CorrectAnswerView(pointsEarned: score) { viewModel.nextQuestion() }
        case .incorrectAnswer(let correctAnswer):
            WrongAnswerView(correctAnswer: correctAnswer) { viewModel.nextQuestion() }
        case .loading:
            Text("Loading...")
        case .firstLoad:
            Text("First load...")
                .onAppear {
                    do {
                        try viewModel.initQuestionnaire()
                    } catch {
                        viewModel.viewState = .error("Something went wrong:", error.localizedDescription)
                    }
                }
        case .error(let title, let description):
            ErrorView(title: title, description: description)
        }
    }
}
