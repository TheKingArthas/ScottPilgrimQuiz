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
                backgroundView
                    .ignoresSafeArea()
            }
    }

    private var mainView: some View {
        VStack {
            explanationTextView
                .padding(.top, LayoutMultiplier.padding(10))
                .padding(.bottom, LayoutMultiplier.padding(6))
            Spacer()
            nextButtonView
        }
    }

    private var explanationTextView: some View {
        VStack {
            Text("Wrong answer!!")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("The correct answer was")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
                .foregroundStyle(CustomColor.destructive)
                .padding(.bottom, LayoutMultiplier.padding(2))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text("\"\(correctAnswer)\"")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
                .foregroundStyle(CustomColor.white)
                .padding(.bottom, LayoutMultiplier.padding(2))
        }
    }

    private var backgroundView: some View {
        VStack {
            Spacer()
            CustomImage.scottDead
                .resizable()
                .scaledToFit()
                .padding(.horizontal, LayoutMultiplier.padding(2))
        }
        .background {
            CustomColor.black
        }
    }

    private var nextButtonView: some View {
        Button {
            nextQuestionAction()
        } label: {
            Text("Next question")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
                .foregroundStyle(CustomColor.primary)
                .foregroundColor(.white)
                .padding(.all, LayoutMultiplier.padding(1))
        }
        .background(CustomColor.secondary)
        .cornerRadius(8)
    }
}

#Preview {
    WrongAnswerView(correctAnswer: "This was actually the correct answer. Better luck next time!") {
        print("Next question pressed")
    }
}
