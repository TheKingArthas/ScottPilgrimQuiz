//
//  PrimaryButton.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUI

struct PrimaryButton: View {
    private let labelText: String
    private let labelColor: Color
    private let hasBackground: Bool
    private let buttonAction: () -> Void
    private let isDisabled: Bool

    init(labelText: String,
         labelColor: Color = CustomColor.primary,
         hasBackground: Bool = false,
         buttonAction: @escaping () -> Void,
         isDisabled: Bool = false) {
        self.labelText = labelText
        self.labelColor = labelColor
        self.hasBackground = hasBackground
        self.buttonAction = buttonAction
        self.isDisabled = isDisabled
    }

    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text(labelText)
                .customModifierTextPrimaryButton()
                .foregroundStyle(isDisabled ? CustomColor.disabled : labelColor)
                .padding(.all, LayoutMultiplier.padding(1))
        }
        .background(hasBackground ? CustomColor.secondary : nil)
        .cornerRadius(8)
        .disabled(isDisabled)
    }
}

#Preview {
    PrimaryButton(labelText: "Press me", hasBackground: true) {}
}
