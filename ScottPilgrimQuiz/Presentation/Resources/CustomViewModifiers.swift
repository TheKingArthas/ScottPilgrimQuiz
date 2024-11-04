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
    func customModifierTextTimer(_ color: Color = CustomColor.primary) -> some View { self.modifier(CustomViewModifiers.Text.Timer(color)) }
    func customModifierTextTitle(_ sizeMultiplier: CGFloat) -> some View { self.modifier(CustomViewModifiers.Text.Title(sizeMultiplier)) }
    func customModifierTextStroke(_ color: Color, _ lineWidth: CGFloat) -> some View { self.modifier(CustomViewModifiers.Text.Stroke(color, lineWidth)) }
    func customModifierTextSubtitle() -> some View { self.modifier(CustomViewModifiers.Text.Subtitle()) }
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
            private let color: Color

            init(_ color: Color) {
                self.color = color
            }

            func body(content: Content) -> some View {
                content
                    .font(CustomFont.karmaticArcade(size: LayoutMultiplier.size(2.5)))
                    .foregroundStyle(color)
                    .multilineTextAlignment(.center)
            }
        }

        struct Title: ViewModifier {
            private let sizeMultiplier: CGFloat

            init(_ sizeMultiplier: CGFloat) {
                self.sizeMultiplier = sizeMultiplier
            }

            func body(content: Content) -> some View {
                content
                    .font(CustomFont.superfly(size: LayoutMultiplier.size(sizeMultiplier)))
                    .foregroundStyle(CustomColor.titleText)
                    .multilineTextAlignment(.center)
            }
        }

        struct Stroke: ViewModifier {
            private let color: Color
            private let lineWidth: CGFloat

            init(_ color: Color, _ lineWidth: CGFloat) {
                self.color = color
                self.lineWidth = lineWidth
            }

            func body(content: Content) -> some View {
                ZStack {
                    content
                        .offset(x: lineWidth, y: lineWidth)
                        .foregroundColor(color)
                    content
                        .offset(x: -lineWidth, y: -lineWidth)
                        .foregroundColor(color)
                    content
                        .offset(x: -lineWidth, y: lineWidth)
                        .foregroundColor(color)
                    content
                        .offset(x: lineWidth, y: -lineWidth)
                        .foregroundColor(color)
                    content
                }
            }
        }

        struct Subtitle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(CustomFont.dusty(size: LayoutMultiplier.size(4)))
                    .foregroundStyle(CustomColor.white)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
