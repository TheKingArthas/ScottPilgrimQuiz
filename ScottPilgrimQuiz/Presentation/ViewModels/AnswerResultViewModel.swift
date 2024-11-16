//
//  QuestionResultViewModel.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 16/11/24.
//

import Foundation

class AnswerResultViewModel: ObservableObject {
    @Published var viewState: AnswerResultViewState

    init(viewState: AnswerResultViewState) {
        self.viewState = viewState
    }
}
