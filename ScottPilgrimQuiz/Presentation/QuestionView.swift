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
            questionView(questionModel.question)
                .padding(.bottom, LayoutMultiplier.size(6))
            answersView(questionModel.answers)
                .frame(maxWidth: .infinity)
            skipButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            CustomColor.background
        }
        .ignoresSafeArea()
    }
    
    private func questionView(_ question: String) -> some View {
        VStack {
            Text("Question \(questionNumber)-\(amountOfTotalQuestions)")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.primary)
                .padding(.vertical, LayoutMultiplier.size(2))
            Text(question)
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                .minimumScaleFactor(0.8)
                .lineLimit(5)
                .multilineTextAlignment(.center)
                .foregroundStyle(CustomColor.white)
        }
        .padding(.horizontal, LayoutMultiplier.padding(2.5))
    }
    
    private func answersView(_ answers: [AnswerModel]) -> some View {
        let shuffledAnswers = answers.shuffled()
        return VStack {
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
            print(answer.isCorrect)
            //TODO: Add flow
        } label: {
            HStack {
                Text("\(answerNumber)")
                    .padding(LayoutMultiplier.padding(2))
                    .background(CustomColor.background)
                    .clipShape(Circle())
                Text(answer.answer)
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
        EmptyView()
    }
    
    private func skipButtonView() -> some View {
        Button {
            print("Question skipped")
            //TODO: Add action
        } label: {
            Text("Skip")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.vertical, LayoutMultiplier.size(2))
        }

    }
}

#Preview {
    QuestionView(questionModel: QuestionModel(id: "0",
                                              question: "What is the name of the first volume in the Scott Pilgrim series?",
                                              answers: [
                                                AnswerModel(id: "1", answer: "Scott Pilgrim's Precious Little Life", isCorrect: true),
                                                AnswerModel(id: "2", answer: "Scott Pilgrim vs. the World", isCorrect: false),
                                                AnswerModel(id: "3", answer: "Scott Pilgrim Gets it Together", isCorrect: false)
                                              ]),
                 questionNumber: 1,
                 amountOfTotalQuestions: 10)
}
