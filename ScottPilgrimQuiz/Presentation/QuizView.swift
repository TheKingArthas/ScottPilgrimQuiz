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
        VStack {
            if let question = viewModel.popRandomQuestion() {
                QuestionView(question: question)
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
