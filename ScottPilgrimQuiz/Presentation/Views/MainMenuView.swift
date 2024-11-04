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
        case .loading:
            LoadingView()
        case .success:
            mainMenuView
        }
    }

    private var mainMenuView: some View {
        HStack {
            mainMenuButton("Start") {}
            mainMenuButton("Highest scores") {}
        }
    }

    private var title: some View {
        Text("Scott Pilgrim Quiz")
            .customModifierTextH1()
    }
}

extension MainMenuView {
    private func mainMenuButton(_ title: String, buttonAction: @escaping () -> Void) -> some View {
        Button {
            buttonAction()
        } label: {
            Text(title)
                .customModifierTextPrimaryButton()
                .padding(.all, LayoutMultiplier.padding(1))
        }
        .background(CustomColor.secondary)
        .cornerRadius(8)
    }
}

#Preview {
    MainMenuView(viewModel: MainMenuViewModel())
}
