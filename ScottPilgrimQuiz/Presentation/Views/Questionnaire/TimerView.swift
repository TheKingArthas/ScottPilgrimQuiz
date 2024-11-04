import SwiftUI

struct TimerView: View {
    @ObservedObject private var viewModel: TimerViewModel

    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("Time remaining: \n\(viewModel.remainingTimeAsFormattedString)")
            .customModifierTextTimer()
            .frame(maxWidth: .infinity)
    }
}
