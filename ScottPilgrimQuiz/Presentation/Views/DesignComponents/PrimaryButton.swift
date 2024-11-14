//
//  PrimaryButton.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUI

enum ButtonArrowDirection {
    case back
    case forward
    case none
}

struct PrimaryButton: View {
    private let labelText: String
    private let labelColor: Color
    private let buttonDirection: ButtonArrowDirection
    private let isDisabled: Bool
    private let buttonAction: () -> Void

    init(labelText: String,
         labelColor: Color = CustomColor.primary,
         buttonDirection: ButtonArrowDirection = .none,
         isDisabled: Bool = false,
         buttonAction: @escaping () -> Void) {
        self.labelText = labelText
        self.labelColor = labelColor
        self.buttonDirection = buttonDirection
        self.isDisabled = isDisabled
        self.buttonAction = buttonAction
    }

    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                if case buttonDirection = ButtonArrowDirection.back { arrowView }
                Text(labelText)
                if case buttonDirection = ButtonArrowDirection.forward { arrowView }
            }
            .customModifierTextPrimaryButton()
            .foregroundStyle(isDisabled ? CustomColor.disabled : labelColor)
            .padding(.all, LayoutMultiplier.padding(2.5))
        }
        .background(isDisabled ? CustomColor.backgroundDisabled : CustomColor.secondary)
        .cornerRadius(8)
        .disabled(isDisabled)
    }

    private var arrowView: some View {
        guard self.buttonDirection != .none else { return AnyView(EmptyView()) }
        let arrowImage = self.buttonDirection == .back ? CustomImage.backArrow : CustomImage.nextArrow

        return AnyView(arrowImage
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: LayoutMultiplier.size(3)))
    }
}

#Preview {
    VStack {
        PrimaryButton(labelText: "Press me",
                      buttonDirection: .back,
                      isDisabled: false) { print("Button pressed")}
        PrimaryButton(labelText: "Press me",
                      buttonDirection: .none,
                      isDisabled: false) { print("Button pressed")}
        PrimaryButton(labelText: "Press me",
                      buttonDirection: .forward,
                      isDisabled: false) { print("Button pressed")}
        PrimaryButton(labelText: "Press me",
                      buttonDirection: .back,
                      isDisabled: true) { print("Button pressed")}
        PrimaryButton(labelText: "Press me",
                      buttonDirection: .none,
                      isDisabled: true) { print("Button pressed")}
        PrimaryButton(labelText: "Press me",
                      buttonDirection: .forward,
                      isDisabled: true) { print("Button pressed")}
    }
}
