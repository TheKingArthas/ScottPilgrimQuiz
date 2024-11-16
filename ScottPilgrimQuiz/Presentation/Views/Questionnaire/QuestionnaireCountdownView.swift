//
//  CountdownView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 15/11/24.
//

import SwiftUI

struct QuestionnaireCountdownView: View {
    @State private var remainingTime: Int = 3
    @State private var timer: Timer? = nil
    private var timeUpAction: () -> Void

    init(timeUpAction: @escaping () -> Void) {
        self.timeUpAction = timeUpAction
    }

    var body: some View {
        mainView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                CustomColor.background
                    .ignoresSafeArea()
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
    }

    private var mainView: some View {
        VStack {
            Text("Get ready!")
                .customModifierTextH2()
                .padding(.bottom, LayoutMultiplier.padding(4))
            Text("\(remainingTime)")
                .customModifierTextH1()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 1 {
                remainingTime -= 1
            } else {
                stopTimer()
                timeUpAction()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    QuestionnaireCountdownView() { print("Time is up!") }
}
