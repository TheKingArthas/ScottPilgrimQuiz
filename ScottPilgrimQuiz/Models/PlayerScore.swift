//
//  PlayerScore.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

struct PlayerScore: Hashable, Comparable {
    static func < (lhs: PlayerScore, rhs: PlayerScore) -> Bool {
        lhs.score < rhs.score
    }

    let name: String
    let score: Int
}
