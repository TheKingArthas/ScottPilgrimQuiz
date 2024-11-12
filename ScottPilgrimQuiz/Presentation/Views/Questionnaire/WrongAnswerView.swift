//
//  IncorrectAnswerView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct WrongAnswerView: View {
    private let correctAnswer: String
    private let nextQuestionAction: () -> Void

    init(correctAnswer: String, nextQuestionAction: @escaping () -> Void) {
        self.correctAnswer = correctAnswer
        self.nextQuestionAction = nextQuestionAction
    }

    var body: some View {
        mainView
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .padding()
            .background {
                CustomColor.black
                    .ignoresSafeArea()
            }
    }

    private var mainView: some View {
        VStack {
            explanationTextView
                .padding(.top, LayoutMultiplier.padding(10))
                .padding(.bottom, LayoutMultiplier.padding(6))
            Spacer()
            wrongAnswerImageView
            nextButtonView
                .padding(.bottom, LayoutMultiplier.padding(4))
        }
    }

    private var explanationTextView: some View {
        VStack {
            Text("Wrong answer!!")
                .customModifierTextH1(CustomColor.destructive)
                .padding(.top, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("The correct answer was")
                .customModifierTextH3(CustomColor.destructive)
                .padding(.bottom, LayoutMultiplier.padding(2))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text("\"\(correctAnswer)\"")
                .customModifierTextH3(CustomColor.white)
                .padding(.bottom, LayoutMultiplier.padding(2))
        }
    }

    private var wrongAnswerImageView: some View {
        CustomImage.scottDead
            .resizable()
            .scaledToFit()
            .padding(.horizontal, LayoutMultiplier.padding(2))
            .padding(.bottom, LayoutMultiplier.padding(1))
    }

    private var nextButtonView: some View {
        PrimaryButton(labelText: "Next question", hasNextArrow: true) { nextQuestionAction() }
    }
}

#Preview {
    WrongAnswerView(correctAnswer: "This was actually the correct answer. Better luck next time!") {
        print("Next question pressed")
    }
}
