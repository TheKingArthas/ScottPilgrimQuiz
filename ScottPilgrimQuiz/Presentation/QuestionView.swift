//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    let questionModel: QuestionModel
    
    var body: some View {
        mainView
    }
    
    private var mainView: some View {
        VStack {
            questionView(questionModel.question)
                .padding(.bottom, LayoutMultiplier.size(8))
            answersView(questionModel.answers)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            CustomColor.background
        }
        .ignoresSafeArea()
    }
    
    private func questionView(_ question: String) -> some View {
        Text(question)
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
            .minimumScaleFactor(0.8)
            .lineLimit(5)
            .multilineTextAlignment(.center)
            .foregroundStyle(CustomColor.white)
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
        } label: {
            HStack {
                Text("\(answerNumber)")
                    .padding(LayoutMultiplier.size(2))
                    .background(CustomColor.background)
                    .clipShape(Circle())
                Text(answer.answer)
                    .frame(maxWidth: .infinity)
            }
            .font(CustomFont.montserrat(size: LayoutMultiplier.size(2.5),
                                        weight: .bold))
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .foregroundStyle(CustomColor.primary)
            .padding(LayoutMultiplier.size(3))
            .background(CustomColor.secondary)
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
                                              ]))
}
