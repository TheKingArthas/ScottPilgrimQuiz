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
    private let hasNextArrow: Bool
    private let isDisabled: Bool
    private let buttonAction: () -> Void

    init(labelText: String,
         labelColor: Color = CustomColor.primary,
         hasNextArrow: Bool = false,
         isDisabled: Bool = false,
         buttonAction: @escaping () -> Void) {
        self.labelText = labelText
        self.labelColor = labelColor
        self.hasNextArrow = hasNextArrow
        self.isDisabled = isDisabled
        self.buttonAction = buttonAction
    }

    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                Text(labelText)
                if hasNextArrow {
                    CustomImage.nextArrow
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(isDisabled ? CustomColor.disabled : labelColor)
                        .scaledToFit()
                    .frame(width: LayoutMultiplier.size(3))}
            }
            .customModifierTextPrimaryButton()
            .foregroundStyle(isDisabled ? CustomColor.disabled : labelColor)
            .padding(.all, LayoutMultiplier.padding(2.5))
        }
        .background(isDisabled ? CustomColor.backgroundDisabled : CustomColor.secondary)
        .cornerRadius(8)
        .disabled(isDisabled)
    }
}

#Preview {
    PrimaryButton(labelText: "Press me",
                  hasNextArrow: true,
                  isDisabled: false) {}
}
