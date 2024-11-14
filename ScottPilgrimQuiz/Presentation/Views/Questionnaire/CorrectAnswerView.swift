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
                .padding(.bottom, LayoutMultiplier.size(2))
        }
    }

    private var titleView: some View {
        Text("Correct !!")
            .customModifierTextH1(CustomColor.positive)
    }

    private func pointsEarnedView(_ amount: Int) -> some View {
        VStack {
            Text("\(amount)")
                .customModifierTextScore(CustomColor.positive)
                .padding(.bottom, LayoutMultiplier.padding(1))
            Text("points \nearned")
                .customModifierTextH2(CustomColor.positive)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }

    private var nextButtonView: some View {
        PrimaryButton(labelText: "Next question", buttonDirection: .forward) { nextQuestionAction() }
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
