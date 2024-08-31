//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    let questionModel: QuestionModel
    let questionNumber: Int
    let amountOfTotalQuestions: Int

    var body: some View {
        mainView
    }

    private var mainView: some View {
        VStack {
            timerView()
                .padding(.bottom, LayoutMultiplier.padding(4))
            questionNumberView(currentQuestionNumber: questionNumber,
                               amountOfTotalQuestions: amountOfTotalQuestions)
            .padding(.bottom, LayoutMultiplier.size(1))
            questionTextView(questionModel.question)
                .padding(.horizontal, LayoutMultiplier.padding(2.5))
                .padding(.bottom, LayoutMultiplier.padding(4))
            answersView(questionModel.allAnswers)
                .frame(maxWidth: .infinity)
            skipButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, LayoutMultiplier.padding(1))
        .background {
            CustomColor.background
                .ignoresSafeArea()
        }
    }

    private func questionNumberView(currentQuestionNumber: Int,
                                    amountOfTotalQuestions: Int) -> some View {
        Text("Question \(currentQuestionNumber)-\(amountOfTotalQuestions)")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
            .foregroundStyle(CustomColor.primary)
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

    private func timerView() -> some View {
        Text("Time remaining: \n00 00")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
            .multilineTextAlignment(.center)
            .foregroundStyle(CustomColor.primary)
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

#Preview {
    QuestionView(questionModel: QuestionModel(id: "999",
                                              question: "What is the name of the first volume in the Scott Pilgrim series?",
                                              correctAnswer: "Scott Pilgrim's Precious Little Life",
                                              wrongAnswers: [
                                                "Scott Pilgrim vs. the World",
                                                "Scott Pilgrim Gets it Together"
                                              ]),
                 questionNumber: 1,
                 amountOfTotalQuestions: 10)
}
