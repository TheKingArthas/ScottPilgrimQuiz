//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: QuestionnaireViewModel

    var body: some View {
        VStack {
            questionTextView()
                .padding(.horizontal, LayoutMultiplier.padding(2.5))
                .padding(.bottom, LayoutMultiplier.padding(4))
            answersView()
                .frame(maxWidth: .infinity)
            skipButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, LayoutMultiplier.padding(1))
        .onAppear {
            viewModel.timerViewModel.startTimer()
        }
    }

    @ViewBuilder
    private func questionTextView() -> some View {
        if let currentQuestion = viewModel.currentQuestion {
            Text(currentQuestion.question)
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                .minimumScaleFactor(0.8)
                .lineLimit(5)
                .multilineTextAlignment(.center)
                .foregroundStyle(CustomColor.white)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func answersView() -> some View {
        if let currentQuestion = viewModel.currentQuestion {
            let shuffledAnswers = currentQuestion.allAnswers.shuffled()
            VStack {
                ForEach(0..<shuffledAnswers.count) { index in
                    answerView(shuffledAnswers[index],
                               answerNumber: index + 1)
                    .padding(.bottom, LayoutMultiplier.padding(1))
                }
            }
        } else {
            EmptyView()
        }
    }

    private func answerView(_ answer: String,
                            answerNumber: Int) -> some View {
        Button {
            viewModel.answer(answer)
        } label: {
            HStack {
                Text("\(answerNumber)")
                    .padding(LayoutMultiplier.padding(2))
                    .background(CustomColor.background)
                    .clipShape(Circle())
                Text(answer)
                    .padding(.leading, LayoutMultiplier.padding(1.5))
                    .frame(maxWidth: .infinity)
            }
            .font(CustomFont.montserrat(size: LayoutMultiplier.size(2.5),
                                        weight: .bold))
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .foregroundStyle(CustomColor.primary)
        }
        .padding(LayoutMultiplier.size(3))
        .background(CustomColor.secondary)
    }

    private func skipButtonView() -> some View {
        Button {
            viewModel.popQuestion()
        } label: {
            Text("Skip question")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }
}
