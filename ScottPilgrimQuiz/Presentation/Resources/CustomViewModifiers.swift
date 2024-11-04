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
    func customModifierTextScore() -> some View { self.modifier(CustomViewModifiers.Text.Score()) }
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

        struct Score: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(10)))
                    .foregroundStyle(CustomColor.positive)
                    .padding(.bottom, LayoutMultiplier.padding(1))
            }
        }
    }
}
