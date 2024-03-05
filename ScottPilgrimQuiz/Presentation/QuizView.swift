//
//  QuizView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject private var viewModel: QuizViewModel
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        QuestionView(question: viewModel.questions.first ?? QuestionModel(question: "",
                                                                          correctAnswer: "",
                                                                          wrongAnswers: ["",""]))
        .onAppear {
            do {
                try viewModel.fetchQuestions()
            } catch {
                print(error)
            }
        }
    }
}
