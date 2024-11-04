//
//  ErrorView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 1/11/24.
//

import SwiftUI

struct ErrorView: View {
    private let title: String
    private let description: String
    private let mainMenuButtonAction: () -> Void

    init(title: String,
         description: String,
         mainMenuButtonAction: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.mainMenuButtonAction = mainMenuButtonAction
    }

    var body: some View {
        VStack {
            Text(title)
                .customModifierTextH1(CustomColor.destructive)
                .multilineTextAlignment(.center)
                .padding(.top, LayoutMultiplier.padding(20))
                .padding(.bottom, LayoutMultiplier.padding(4))
            Text(description)
                .customModifierTextH3(CustomColor.white)
            Spacer()
            PrimaryButton(labelText: "Main menu") { mainMenuButtonAction() }
        }
        .padding(.horizontal, LayoutMultiplier.padding(2))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            CustomColor.backgroundDestructive
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ErrorView(title:"Something failed",
              description: "This is a detailed description of what happened.") {}
}
