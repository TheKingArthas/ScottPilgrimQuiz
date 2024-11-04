//
//  MainMenuViewState.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

enum MainMenuViewState {
    case error(_ title: String, _ description: String)
    case firstLoad
    case loading
    case success
}
