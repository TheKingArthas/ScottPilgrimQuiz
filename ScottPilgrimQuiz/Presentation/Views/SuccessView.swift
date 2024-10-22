//
//  SuccessView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 30/8/24.
//

import SwiftUI

struct SuccessView: View {
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
            correctTextView
                .padding(.top, LayoutMultiplier.padding(10))
                .padding(.bottom, LayoutMultiplier.padding(6))
            pointsEarnedView(10)
            Spacer()
            nextButtonView
        }
    }

    private var correctTextView: some View {
        Text("Correct !!")
            .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
            .foregroundStyle(CustomColor.positive)
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

    private var nextButtonView: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("Next question")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                .foregroundStyle(CustomColor.primary)
                .padding(.vertical, LayoutMultiplier.size(2))
        })
        .clipShape(Circle())
        .background {
            CustomColor.white
        }
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
}

#Preview {
    SuccessView()
}
