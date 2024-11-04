//
//  CustomViewModifiers.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUICore

extension View {
    func customModifierTextH1(_ color: Color = CustomColor.primary) -> some View { self.modifier(CustomViewModifiers.Text.H1(color)) }
    func customModifierTextH2(_ color: Color = CustomColor.primary) -> some View { self.modifier(CustomViewModifiers.Text.H2(color)) }
    func customModifierTextH3(_ color: Color = CustomColor.primary) -> some View { self.modifier(CustomViewModifiers.Text.H3(color)) }
    func customModifierTextLoading() -> some View { self.modifier(CustomViewModifiers.Text.Loading()) }
    func customModifierTextPrimaryButton() -> some View { self.modifier(CustomViewModifiers.Text.PrimaryButton()) }
    func customModifierTextQuestion() -> some View { self.modifier(CustomViewModifiers.Text.Question()) }
    func customModifierTextScore(_ color: Color = CustomColor.primary) -> some View { self.modifier(CustomViewModifiers.Text.Score(color)) }
    func customModifierTextTimer() -> some View { self.modifier(CustomViewModifiers.Text.Timer()) }
}

fileprivate struct CustomViewModifiers {
    struct Text {
        struct H1: ViewModifier {
            private let color: Color

            init(_ color: Color) {
                self.color = color
            }

            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(6)))
                    .foregroundStyle(color)
            }
        }

        struct H2: ViewModifier {
            private let color: Color

            init(_ color: Color) {
                self.color = color
            }

            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(4)))
                    .foregroundStyle(color)
            }
        }

        struct H3: ViewModifier {
            private let color: Color

            init(_ color: Color) {
                self.color = color
            }

            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(3)))
                    .foregroundStyle(color)
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
            private let color: Color

            init(_ color: Color) {
                self.color = color
            }

            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(10)))
                    .foregroundStyle(color)
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
