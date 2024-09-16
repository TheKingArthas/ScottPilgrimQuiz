//
//  QuizView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuizView: View {
    private var viewModel: QuizViewModel
    @State private var currentQuestionNumber: Int = 1
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        do {
            try self.viewModel.fetchQuestions()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            if let question = viewModel.popQuestion() {
                QuestionView(questionModel: question,
                             questionNumber: currentQuestionNumber,
                             amountOfTotalQuestions: viewModel.amountOfQuestions)
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
