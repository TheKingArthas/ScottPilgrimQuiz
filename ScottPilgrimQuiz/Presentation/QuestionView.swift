//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    let question: QuestionModel
    
    var body: some View {
        VStack {
            Text(question.question)
            Text(question.correctAnswer)
            Text(question.wrongAnswers[0])
            Text(question.wrongAnswers[1])
        }
    }
}

#Preview {
    QuestionView(question: QuestionModel(question: "Is true?",
                                         correctAnswer: "It is",
                                         wrongAnswers: [
                                            "Wrong anwser",
                                            "Another wrong answer"
                                         ]))
}
