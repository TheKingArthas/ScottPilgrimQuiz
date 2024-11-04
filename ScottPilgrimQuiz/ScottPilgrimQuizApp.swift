//
//  ScottPilgrimQuizApp.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/3/24.
//

import SwiftUI

@main
struct ScottPilgrimQuizApp: App {
    var body: some Scene {
        WindowGroup {
            QuestionnaireView(viewModel: QuestionnaireViewModel(amountOfQuestions: 10,
                                                                questionsService: QuestionService()))
        }
    }
}
