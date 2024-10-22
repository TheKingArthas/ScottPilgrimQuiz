//
//  QuizView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionnaireView: View {
    @State private var viewModel: QuestionnaireViewModel

    init(viewModel: QuestionnaireViewModel) {
        self.viewModel = viewModel
        do {
            try self.viewModel.fetchQuestions()
        } catch {
            print(error)
        }
    }

    var body: some View {
        mainView
            .background {
                CustomColor.background
                    .ignoresSafeArea()
            }
            .onAppear {
                do {
                    try viewModel.fetchQuestions()
                    viewModel.popQuestion()
                } catch {
                    print(error)
                }
            }
    }

    private var mainView: some View {
        VStack {
            timerView()
                .padding(.bottom, LayoutMultiplier.padding(4))
            questionNumberView(currentQuestionNumber: viewModel.currentQuestionNumber,
                               amountOfTotalQuestions: viewModel.amountOfQuestions)
            .padding(.bottom, LayoutMultiplier.size(1))
            if viewModel.currentQuestion != nil {
                QuestionView(viewModel: $viewModel)
            }
        }
    }

    private func timerView() -> some View {
        Text("Time remaining: \n00 00")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
            .multilineTextAlignment(.center)
            .foregroundStyle(CustomColor.primary)
    }

    private func questionNumberView(currentQuestionNumber: Int,
                                    amountOfTotalQuestions: Int) -> some View {
        Text("Question \(currentQuestionNumber)-\(amountOfTotalQuestions)")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
            .foregroundStyle(CustomColor.primary)
    }
}
