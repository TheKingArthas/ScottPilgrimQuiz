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
    @Environment(\.dismiss) private var dismiss

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    var body: some View {
        VStack {
            Text(title)
                .customModifierTextH1(CustomColor.destructive)
                .multilineTextAlignment(.center)
                .padding(.top, LayoutMultiplier.padding(20))
                .padding(.bottom, LayoutMultiplier.padding(4))
            Text(description)
                .customModifierTextBody(CustomColor.white)
            Spacer()
            PrimaryButton(labelText: "Main menu") { dismiss() }
        }
        .padding(.horizontal, LayoutMultiplier.padding(2))
        .padding(.bottom, LayoutMultiplier.size(2))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            CustomColor.backgroundDestructive
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ErrorView(title:"Something failed",
              description: "This is a detailed description of what happened.")
}
