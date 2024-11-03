//
//  TimerViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 22/10/24.
//

import Foundation
import SwiftUICore

class TimerViewModel: ObservableObject {
    @Published private(set) var remainingTime: Int
    private let initialTime: Int
    private var timer: Timer

    var remainingTimeAsFormattedString: String {
        if remainingTime > 0 {
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return "--:--"
        }
    }

    init(initialTime: Int) {
        self.initialTime = initialTime
        self.remainingTime = initialTime
        self.timer = .init()
    }

    var body: some View {
        VStack {
            Text(remainingTimeAsFormattedString)
                .font(.largeTitle)
        }
    }

    func startTimer() {
        remainingTime = initialTime
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        timer.invalidate()
    }
}
