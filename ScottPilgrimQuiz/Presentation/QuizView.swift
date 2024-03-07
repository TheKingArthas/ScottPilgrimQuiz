//
//  QuizView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject private var viewModel: QuizViewModel
    @State private var currentQuestionNumber: Int = 1
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if let question = viewModel.popRandomQuestion() {
                QuestionView(questionModel: question,
                             questionNumber: currentQuestionNumber,
                             amountOfTotalQuestions: viewModel.amountOfRandomQuestions)
            }
        }
        .onAppear {
            do {
                try viewModel.fetchQuestions()
            } catch {
                print(error)
            }
        }
    }
}
