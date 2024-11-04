//
//  SuccessView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 30/8/24.
//

import SwiftUI

struct CorrectAnswerView: View {
    private let pointsEarned: Int
    private let nextQuestionAction: () -> Void

    init(pointsEarned: Int, nextQuestionAction: @escaping () -> Void) {
        self.pointsEarned = pointsEarned
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
            titleView
                .padding(.top, LayoutMultiplier.padding(10))
                .padding(.bottom, LayoutMultiplier.padding(6))
            pointsEarnedView(pointsEarned)
            Spacer()
            nextButtonView
        }
    }

    private var titleView: some View {
        Text("Correct !!")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
            .foregroundStyle(CustomColor.positive)
    }

    private func pointsEarnedView(_ amount: Int) -> some View {
        VStack {
            Text("\(amount)")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(10)))
                .foregroundStyle(CustomColor.positive)
                .padding(.bottom, LayoutMultiplier.padding(1))
            Text("points \nearned")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(CustomColor.positive)
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

    private var backgroundView: some View {
        VStack {
            Spacer()
            CustomImage.scottJumping
                .resizable()
                .scaledToFit()
                .padding(.horizontal, LayoutMultiplier.padding(2))
        }
        .background {
            CustomColor.background
        }
    }
}

#Preview {
    CorrectAnswerView(pointsEarned: 10) {
        print("Next question pressed")
    }
}
