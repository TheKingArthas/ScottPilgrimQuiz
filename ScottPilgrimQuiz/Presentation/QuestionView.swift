//
//  QuestionView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import SwiftUI

struct QuestionView: View {
    let questionModel: QuestionModel
    
    var body: some View {
        mainView
    }
    
    private var mainView: some View {
        VStack {
            questionView(questionModel.question)
            answersView(questionModel.answers)
        }
    }
    
    private func questionView(_ question: String) -> some View {
        Text(question)
    }
    
    private func answersView(_ answers: [AnswerModel]) -> some View {
        let shuffledAnswers = answers.shuffled()
        return List {
            ForEach(shuffledAnswers) { answer in
                answerView(answer)
            }
        }
    }
    
    private func answerView(_ answer: AnswerModel) -> some View {
        Text(answer.answer)
    }
}

#Preview {
    QuestionView(questionModel: QuestionModel(id: "0",
                                              question: "Is true?",
                                              answers: [
                                                AnswerModel(id: "1", answer: "Correct answer", isCorrect: true),
                                                AnswerModel(id: "2", answer: "Wrong answer", isCorrect: false),
                                                AnswerModel(id: "3", answer: "Another wrong answer", isCorrect: false)
                                              ]))
}
