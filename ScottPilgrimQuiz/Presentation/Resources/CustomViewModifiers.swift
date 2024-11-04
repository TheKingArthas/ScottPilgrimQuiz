//
//  CustomViewModifiers.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUICore

extension View {
    func customModifierTextH1() -> some View { self.modifier(CustomViewModifiers.Text.H1()) }
    func customModifierTextH2() -> some View { self.modifier(CustomViewModifiers.Text.H1()) }
    func customModifierTextLoading() -> some View { self.modifier(CustomViewModifiers.Text.Loading()) }
    func customModifierTextPrimaryButton() -> some View { self.modifier(CustomViewModifiers.Text.PrimaryButton()) }
    func customModifierTextQuestion() -> some View { self.modifier(CustomViewModifiers.Text.Question()) }
    func customModifierTextScore() -> some View { self.modifier(CustomViewModifiers.Text.Score()) }
    func customModifierTextTimer() -> some View { self.modifier(CustomViewModifiers.Text.Timer()) }
}

fileprivate struct CustomViewModifiers {
    struct Text {
        struct H1: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
                    .foregroundStyle(CustomColor.positive)
            }
        }

        struct H2: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
                    .foregroundStyle(CustomColor.positive)
            }
        }

        struct Loading: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2)))
                    .foregroundStyle(CustomColor.white)
            }
        }

        struct PrimaryButton: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
            }
        }

        struct Question: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                    .minimumScaleFactor(0.6)
                    .lineLimit(4)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(CustomColor.white)
            }
        }

        struct Score: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(10)))
                    .foregroundStyle(CustomColor.positive)
            }
        }

        struct Timer: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                    .foregroundStyle(CustomColor.primary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
