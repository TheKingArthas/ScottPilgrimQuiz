//
//  QuestionResultView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 16/11/24.
//

import SwiftUI

struct AnswerResultView: View {
    private var viewState: AnswerResultViewState
    private let nextQuestionAction: () -> Void
    
    init(viewState: AnswerResultViewState, nextQuestionAction: @escaping () -> Void) {
        self.viewState = viewState
        self.nextQuestionAction = nextQuestionAction
    }
    
    var body: some View {
        mainView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                backgroundReducer(viewState)
                    .ignoresSafeArea()
            }
    }
    
    private var mainView: some View {
        VStack {
            switch viewState {
            case .correctAnswer(let score, _):
                correctAnswerView(score: score)
            case .wrongAnswer(let correctAnswer, _):
                wrongAnswerView(correctAnswer: correctAnswer)
            case .timeIsUp(_):
                timeIsUpView
            }
            Spacer()
            nextButtonView(viewState)
                .padding(.bottom, LayoutMultiplier.padding(4))
        }
    }
    
    private var timeIsUpView: some View {
        VStack {
            Text("Time is up!")
                .customModifierTextH1(CustomColor.destructive)
                .padding(.top, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("Try to be faster next time")
                .customModifierTextBody(CustomColor.white)
                .padding(.bottom, LayoutMultiplier.padding(2))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding(.top, LayoutMultiplier.padding(10))
        .padding(.bottom, LayoutMultiplier.padding(6))
    }
    
    private func correctAnswerView(score: Int) -> some View {
        VStack {
            Text("Correct !!")
                .customModifierTextH1(CustomColor.positive)
                .padding(.top, LayoutMultiplier.padding(10))
                .padding(.bottom, LayoutMultiplier.padding(6))
            Text("\(score)")
                .customModifierTextScore(CustomColor.positive)
                .padding(.bottom, LayoutMultiplier.padding(1))
            Text("points \nearned")
                .customModifierTextH2(CustomColor.positive)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
    
    private func wrongAnswerView(correctAnswer: String) -> some View {
        VStack {
            Text("Wrong answer!!")
                .customModifierTextH1(CustomColor.destructive)
                .padding(.top, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(2))
            Text("The correct answer was")
                .customModifierTextBody(CustomColor.destructive)
                .padding(.bottom, LayoutMultiplier.padding(2))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text("\"\(correctAnswer)\"")
                .customModifierTextBody(CustomColor.white)
                .padding(.bottom, LayoutMultiplier.padding(2))
        }
        .padding(.top, LayoutMultiplier.padding(10))
        .padding(.bottom, LayoutMultiplier.padding(6))
    }
    
    private func nextButtonView(_ viewState: AnswerResultViewState) -> some View {
        switch viewState {
        case .correctAnswer(_, let isLastQuestion),
                .wrongAnswer(_, let isLastQuestion),
                .timeIsUp(let isLastQuestion):
            PrimaryButton(labelText: isLastQuestion ? "Finish" : "Next question",
                          buttonDirection: .forward) {
                nextQuestionAction()
            }
        }
    }
}

extension AnswerResultView {
    @ViewBuilder
    private func backgroundReducer(_ viewState: AnswerResultViewState) -> some View {
        switch viewState {
        case .correctAnswer(_, _):
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
        case .wrongAnswer(_, _):
            ZStack {
                CustomColor.black
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    CustomImage.scottDead
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, LayoutMultiplier.padding(2))
                        .padding(.bottom, LayoutMultiplier.padding(1))
                }
                CustomColor.black.opacity(0.8)
            }
        case .timeIsUp(_):
            VStack {
                Spacer()
                CustomImage.ramonaAiming
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, LayoutMultiplier.padding(2))
            }
            .background {
                CustomColor.backgroundDestructive
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    AnswerResultView(viewState: .correctAnswer(score: 20, isLastQuestion: false),
                     nextQuestionAction: { print("Next") })
}
