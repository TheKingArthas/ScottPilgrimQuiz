//
//  LoadingView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import SwiftUI

struct LoadingView: View {
    @State var degreesRotating = 0.0

    var body: some View {
        VStack {
            CustomImage.lucasLeeSkating
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom, LayoutMultiplier.padding(1))
                .rotationEffect(.degrees(degreesRotating))
                .onAppear {
                    withAnimation(.linear(duration: 1)
                        .speed(0.8).repeatForever(autoreverses: false)) {
                            degreesRotating = 360.0
                        }
                }
            Text("Loading...")
                .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2)))
                .foregroundStyle(CustomColor.white)
        }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background {
                CustomColor.background
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    LoadingView()
}
