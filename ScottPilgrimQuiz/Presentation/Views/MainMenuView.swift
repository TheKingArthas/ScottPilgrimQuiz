//
//  MainMenuView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel: MainMenuViewModel
    @State private var floating: Bool = false

    init(viewModel: MainMenuViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            mainView
                .navigationDestination(for: RouterDestination.self) { destination in
                    RouterReducer().reduce(destination)
                }
        }
    }

    @ViewBuilder
    var mainView: some View {
        switch viewModel.viewState {
        case let .error(title, description):
            ErrorView(title: title, description: description)
        case .firstLoad:
            LoadingView()
                .onAppear {
                    viewModel.viewState = .success
                }
        case .loading:
            LoadingView()
        case .success:
            mainMenuView
        }
    }

    private var mainMenuView: some View {
        VStack {
            title
                .padding(.top, LayoutMultiplier.padding(12))
                .frame(maxHeight: 250, alignment: floating ? .bottom : .top)
                .customModifierEffectFloating(2.5, floating)
                .onAppear {
                    self.floating.toggle()
                }
            Spacer()
            gameButtons
                .padding(.bottom, LayoutMultiplier.padding(4))
            helpButton
                .padding(.bottom, 0)
        }
        .background {
            CustomImage.scottPilgrimAllCharacters
        }
    }

    private var helpButton: some View {
        HStack {
            Spacer()
            NavigationLink(value: RouterDestination.help) {
                mainMenuButton(title: "?",
                               width: LayoutMultiplier.padding(5),
                               height: LayoutMultiplier.padding(5))
            }
        }
    }

    private var title: some View {
        VStack {
            Text("SCOTT")
                .customModifierEffectStroke(CustomColor.black, 8)
                .customModifierTextTitle(10)
                .padding(.bottom, LayoutMultiplier.padding(-8))
            Text("PILGRIM")
                .customModifierEffectStroke(CustomColor.black, 8)
                .customModifierTextTitle(12)
                .padding(.bottom, LayoutMultiplier.padding(-3))
            Text("VS THE QUIZ")
                .customModifierEffectStroke(CustomColor.black, 5)
                .customModifierTextSubtitle()
                .background { CustomColor.black }
        }
    }

    private var gameButtons: some View {
        let width = LayoutMultiplier.size(19)
        let height = LayoutMultiplier.size(14)

        return HStack(spacing: LayoutMultiplier.padding(5)) {
            NavigationLink(value: RouterDestination.quiz) {
                mainMenuButton(title: "Start",
                               width: width,
                               height: height)
            }
            NavigationLink(value: RouterDestination.highestScores) {
                mainMenuButton(title: "Highest scores",
                               width: width,
                               height: height)
            }
        }
    }
}

extension MainMenuView {
    private func mainMenuButton(title: String, width: CGFloat, height: CGFloat) -> some View {
        Text(title)
            .customModifierTextPrimaryButton()
            .frame(width: width, height: height)
            .foregroundStyle(CustomColor.primary)
            .background(CustomColor.secondary)
            .cornerRadius(8)
    }
}

#Preview {
    MainMenuView(viewModel: MainMenuViewModel())
}
