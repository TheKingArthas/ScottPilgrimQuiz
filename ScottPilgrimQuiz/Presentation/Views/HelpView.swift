//
//  HelpView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 13/11/24.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        mainView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                CustomColor.background
                    .ignoresSafeArea()
            }
    }

    private var mainView: some View {
        VStack {
            titleView
                .customModifierTextH2()
                .padding(.top, LayoutMultiplier.padding(10))
                .padding(.bottom, LayoutMultiplier.padding(6))
            descriptionView
                .customModifierTextBody(CustomColor.white)
                .padding(.horizontal, LayoutMultiplier.padding(4))
                .padding(.bottom, LayoutMultiplier.padding(6))
            Spacer()
            backButtonView
                .padding(.bottom, LayoutMultiplier.size(2))
        }
    }

    private var titleView: some View {
        Text("Instructions")
    }

    private var descriptionView: some View {
        ScrollView {
            Text(Instructions().description)
        }
    }

    private var backButtonView: some View {
        PrimaryButton(labelText: "Go back", buttonDirection: .back) { dismiss() }
    }
}

#Preview {
    HelpView()
}
