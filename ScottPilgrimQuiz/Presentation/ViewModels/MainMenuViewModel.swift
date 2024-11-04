//
//  MainView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import Foundation

class MainMenuViewModel: ObservableObject {
    @Published var viewState: MainMenuViewState = .firstLoad
}
