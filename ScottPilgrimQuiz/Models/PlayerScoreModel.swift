//
//  PlayerScore.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

struct PlayerScoreModel: Hashable, Comparable, Codable {
    static func < (lhs: PlayerScoreModel, rhs: PlayerScoreModel) -> Bool {
        lhs.score < rhs.score
    }

    let name: String
    let score: Int
}
