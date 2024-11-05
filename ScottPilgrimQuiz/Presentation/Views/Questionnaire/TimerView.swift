import SwiftUI

struct TimerView: View {
    @ObservedObject private var viewModel: TimerViewModel

    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("Time remaining:")
                .customModifierTextQuestionNumber()
                .frame(maxWidth: .infinity)
                .padding(.bottom, LayoutMultiplier.padding(0.5))
            Text(viewModel.remainingTimeAsFormattedString)
                .customModifierTextTimer(viewModel.isOnCriticalTime ? CustomColor.destructive : CustomColor.primary)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TimerView(viewModel: .init(initialTime: 30) {})
}
