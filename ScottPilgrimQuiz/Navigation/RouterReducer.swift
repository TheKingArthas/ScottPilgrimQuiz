//
//  RouterReducer.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 4/11/24.
//

import SwiftUICore

enum RouterDestination: Hashable {
    case quiz
    case highestScores
}

struct RouterReducer {
    @ViewBuilder
    func reduce(_ destination: RouterDestination) -> some View {
        switch destination {
        case .highestScores:
            HighestScoresView([])
                .navigationBarBackButtonHidden(true)
        case .quiz:
            QuestionnaireView(viewModel: QuestionnaireViewModel(amountOfQuestions: 10,
                                                                questionsService: QuestionService()))
            .navigationBarBackButtonHidden(true)
        }
    }
}
