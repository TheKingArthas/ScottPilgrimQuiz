//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    private let currentQuestionNumber: Int
    private let amountOfTotalQuestions: Int
    private let currentQuestion: QuestionModel
    private let timer: TimerViewModel
    private let answerAction: (String) -> Void
    private let skipQuestionAction: () -> Void

    init(currentQuestionNumber: Int,
         amountOfTotalQuestions: Int,
         currentQuestion: QuestionModel,
         timer: TimerViewModel,
         answerAction: @escaping (String) -> Void,
         skipQuestionAction: @escaping () -> Void) {
        self.currentQuestionNumber = currentQuestionNumber
        self.amountOfTotalQuestions = amountOfTotalQuestions
        self.currentQuestion = currentQuestion
        self.timer = timer
        self.answerAction = answerAction
        self.skipQuestionAction = skipQuestionAction
    }

    var body: some View {
        VStack {
            TimerView(viewModel: timer)
                .padding(.bottom, LayoutMultiplier.padding(4))
            questionNumberView(currentQuestionNumber: currentQuestionNumber,
                               amountOfTotalQuestions: amountOfTotalQuestions)
            .padding(.bottom, LayoutMultiplier.size(1))
            questionTextView()
                .padding(.horizontal, LayoutMultiplier.padding(2.5))
                .padding(.bottom, LayoutMultiplier.padding(4))
            answersView()
                .frame(maxWidth: .infinity)
            skipButtonView()
        }
    }

    @ViewBuilder
    private func questionTextView() -> some View {
        Text(currentQuestion.question)
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
            .minimumScaleFactor(0.8)
            .lineLimit(5)
            .multilineTextAlignment(.center)
            .foregroundStyle(CustomColor.white)
    }

    @ViewBuilder
    private func answersView() -> some View {
        let shuffledAnswers = currentQuestion.allAnswers.shuffled()
        VStack {
            ForEach(0..<shuffledAnswers.count) { index in
                answerView(shuffledAnswers[index],
                           answerNumber: index + 1)
                .padding(.bottom, LayoutMultiplier.padding(1))
            }
        }
    }

    private func questionNumberView(currentQuestionNumber: Int,
                                    amountOfTotalQuestions: Int) -> some View {
        Text("Question \(currentQuestionNumber)-\(amountOfTotalQuestions)")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
            .foregroundStyle(CustomColor.primary)
    }

    private func answerView(_ answer: String,
                            answerNumber: Int) -> some View {
        Button {
            answerAction(answer)
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
            skipQuestionAction()
        } label: {
            Text("Skip question")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }

    private func handleAnswer(_ answer: String) {
        answerAction(answer)
    }
}

#Preview {
    QuestionView(currentQuestionNumber: 3,
                 amountOfTotalQuestions: 10,
                 currentQuestion: QuestionModel(id: "3",
                                                question: "This is correct?",
                                                correctAnswer: "Yes",
                                                wrongAnswers: ["No", "Ney", "Also no"]),
                 timer: TimerViewModel(initialTime: 30)) { _ in } skipQuestionAction: {}
}
