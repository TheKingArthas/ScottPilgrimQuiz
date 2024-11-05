//
//  TimeIsUpView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUI

struct TimeIsUpView: View {
    private let nextQuestionAction: () -> Void

    init(nextQuestionAction: @escaping () -> Void) {
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
                .padding(.vertical, LayoutMultiplier.padding(4))
        }
    }

    private var explanationTextView: some View {
        VStack {
            Text("Time is up!")
                .customModifierTextH1(CustomColor.destructive)
                .padding(.top, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("Try to be faster next time")
                .customModifierTextH3(CustomColor.white)
                .padding(.bottom, LayoutMultiplier.padding(2))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }

    private var nextButtonView: some View {
        PrimaryButton(labelText: "Next question", hasNextArrow: true) { nextQuestionAction() }
    }

    private var backgroundView: some View {
        VStack {
            Spacer()
            CustomImage.ramonaAiming
                .resizable()
                .scaledToFit()
                .padding(.horizontal, LayoutMultiplier.padding(2))
        }
        .background {
            CustomColor.backgroundDestructive
        }
    }
}

#Preview {
    TimeIsUpView() {}
}
