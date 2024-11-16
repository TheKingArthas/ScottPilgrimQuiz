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
        case .loading:
            LoadingView()
        case .firstLoad:
            LoadingView()
                .onAppear {
                    do {
                        try viewModel.fetchQuestions()
                    } catch {
                        viewModel.viewState = .error("Something went wrong:", error.localizedDescription)
                    }
                }
        case .questionnaireCountdown:
            QuestionnaireCountdownView() { viewModel.nextQuestion() }
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
        case let .correctAnswer(score):
            AnswerResultView(viewState: .correctAnswer(score: score,
                                                       isLastQuestion: viewModel.isLastQuestion)) {
                viewModel.nextQuestion()
            }
        case let .wrongAnswer(correctAnswer):
            AnswerResultView(viewState: .wrongAnswer(correctAnswer: correctAnswer,
                                                     isLastQuestion: viewModel.isLastQuestion)) {
                viewModel.nextQuestion()
            }
        case .timeIsUp:
            AnswerResultView(viewState: .timeIsUp(isLastQuestion: viewModel.isLastQuestion)) {
                viewModel.nextQuestion()
            }
        case let .finished(playerScore: playerScore):
            GameOverView(viewModel: GameOverViewModel(scoreService: ScoreService()),
                         playerScore: playerScore)
        case let .error(title, description):
            ErrorView(title: title, description: description)
        }
    }
}
