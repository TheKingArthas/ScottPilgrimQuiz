//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    private let questionModel: QuestionModel
    private let viewModel: QuizViewModel

    init(_ questionModel: QuestionModel, _ viewModel: QuizViewModel) {
        self.questionModel = questionModel
        self.viewModel = viewModel
    }

    var body: some View {
        mainView
    }

    private var mainView: some View {
        VStack {
            questionTextView(questionModel.question)
                .padding(.horizontal, LayoutMultiplier.padding(2.5))
                .padding(.bottom, LayoutMultiplier.padding(4))
            answersView(questionModel.allAnswers)
                .frame(maxWidth: .infinity)
            skipButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, LayoutMultiplier.padding(1))
    }

    private func questionTextView(_ question: String) -> some View {
        Text(question)
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
            .minimumScaleFactor(0.8)
            .lineLimit(5)
            .multilineTextAlignment(.center)
            .foregroundStyle(CustomColor.white)
    }

    private func answersView(_ answers: [String]) -> some View {
        let shuffledAnswers = answers.shuffled()
        return VStack {
            ForEach(0..<shuffledAnswers.count) { index in
                answerView(shuffledAnswers[index],
                           answerNumber: index + 1)
                .padding(.bottom, LayoutMultiplier.padding(1))
            }
        }
    }

    private func answerView(_ answer: String,
                            answerNumber: Int) -> some View {
        Button {
            //TODO: Add flow
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
            print("Question skipped")
            //TODO: Add action
        } label: {
            Text("Skip question")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }
    }
}
