//
//  ErrorView.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 1/11/24.
//

import SwiftUI

struct ErrorView: View {
    private let title: String
    private let description: String

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    var body: some View {
        VStack {
            Text(title)
            Text(description)
        }
    }
}

#Preview {
    ErrorView(title:"Something failed",
              description: "This is a detailed description of what happened.")
}
