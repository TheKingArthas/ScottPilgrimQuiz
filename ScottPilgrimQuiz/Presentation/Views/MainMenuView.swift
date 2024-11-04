//
//  MainMenuView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel: MainMenuViewModel

    init(viewModel: MainMenuViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        mainView
    }

    @ViewBuilder
    var mainView: some View {
        switch viewModel.viewState {
        case let .error(title, description):
            ErrorView(title: title, description: description) { viewModel.viewState = .firstLoad }
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
            Spacer()
            HStack(spacing: LayoutMultiplier.padding(5)) {
                mainMenuButton(title: "Start",
                               textColor: CustomColor.primary) {}
                mainMenuButton(title: "Highest scores",
                               textColor: CustomColor.primary) {}
            }
            .padding(.bottom, LayoutMultiplier.padding(10))
        }
        .background {
            CustomImage.scottPilgrimAllCharacters
        }
    }

    private var title: some View {
        VStack {
            Text("SCOTT")
                .customModifierTextStroke(CustomColor.black, 8)
                .customModifierTextTitle(10)
                .padding(.bottom, LayoutMultiplier.padding(-8))
            Text("PILGRIM")
                .customModifierTextStroke(CustomColor.black, 8)
                .customModifierTextTitle(12)
                .padding(.bottom, LayoutMultiplier.padding(-3))
            Text("VS THE QUIZ")
                .customModifierTextStroke(CustomColor.black, 5)
                .customModifierTextSubtitle()
                .background { CustomColor.black }
        }
    }
}

extension MainMenuView {
    private func mainMenuButton(title: String,
                                textColor: Color,
                                buttonAction: @escaping () -> Void) -> some View {
        Button {
            buttonAction()
        } label: {
            Text(title)
                .customModifierTextPrimaryButton()
                .foregroundStyle(textColor)
                .padding(.all, LayoutMultiplier.padding(1))
        }
        .frame(width: LayoutMultiplier.size(19), height: LayoutMultiplier.size(14))
        .background(CustomColor.secondary)
        .cornerRadius(8)
    }
}

#Preview {
    MainMenuView(viewModel: MainMenuViewModel())
}
