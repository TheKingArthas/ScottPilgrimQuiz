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
    private let answerAction: (AnswerModel) -> Void
    private let skipQuestionAction: () -> Void

    init(currentQuestionNumber: Int,
         amountOfTotalQuestions: Int,
         currentQuestion: QuestionModel,
         timer: TimerViewModel,
         answerAction: @escaping (AnswerModel) -> Void,
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
                .padding(.top, LayoutMultiplier.padding(8))
                .padding(.bottom, LayoutMultiplier.padding(2))
            questionNumberView(currentQuestionNumber: currentQuestionNumber,
                               amountOfTotalQuestions: amountOfTotalQuestions)
            .padding(.bottom, LayoutMultiplier.size(1))
            Spacer()
            questionTextView()
                .padding(.horizontal, LayoutMultiplier.padding(2.5))
                .padding(.bottom, LayoutMultiplier.padding(4))
            answersView()
                .frame(maxWidth: .infinity)
                .padding(.bottom, LayoutMultiplier.padding(2))
            skipQuestionButtonView()
                .padding(.vertical, LayoutMultiplier.size(4))
        }
    }

    private func questionNumberView(currentQuestionNumber: Int,
                                    amountOfTotalQuestions: Int) -> some View {
        Text("Question \(currentQuestionNumber)-\(amountOfTotalQuestions)")
            .customModifierTextTimer()
    }

    @ViewBuilder
    private func questionTextView() -> some View {
        Text(currentQuestion.question)
            .customModifierTextQuestion()
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

    private func answerView(_ answer: AnswerModel,
                            answerNumber: Int) -> some View {
        Button {
            answerAction(answer)
        } label: {
            HStack {
                Text("\(answerNumber)")
                    .padding(LayoutMultiplier.padding(2))
                    .background(CustomColor.background)
                    .clipShape(Circle())
                Text(answer.description)
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

    private func skipQuestionButtonView() -> some View {
        PrimaryButton(labelText: "Skip question", labelColor: CustomColor.destructive) { skipQuestionAction() }
    }
}

#Preview {
    QuestionView(currentQuestionNumber: 3,
                 amountOfTotalQuestions: 10,
                 currentQuestion: QuestionModel(id: "Q3",
                                                question: "This is correct?",
                                                correctAnswer: AnswerModel(id: "Q3A1", description: "Yes"),
                                                wrongAnswers: [
                                                    AnswerModel(id: "Q3A2", description: "No"),
                                                    AnswerModel(id: "Q3A3", description: "Ney"),
                                                    AnswerModel(id: "Q3A4", description: "Also no")
                                                ]),
                 timer: TimerViewModel(initialTime: 30)) { _ in } skipQuestionAction: {}
}
