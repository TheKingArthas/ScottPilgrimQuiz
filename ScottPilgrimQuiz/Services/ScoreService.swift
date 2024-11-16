//
//  ScoreService.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

class ScoreService {
    static private let scoresKey = "questionsAJFPIJEPOA"
    static private let amountOfTopScores: Int = 10

    private(set) var highestScores: [PlayerScoreModel]

    init() {
        self.highestScores = []
    }

    func fetchHighestScores() throws {
        highestScores = try retrieveFromUserDefaults() ?? []
    }

    func isInTopScores(_ score: Int) -> Bool {
        if score > 0 {
            return highestScores.count < Self.amountOfTopScores ? true : highestScores.contains(where: { score > $0.score })
        } else {
            return false
        }
    }

    func saveScore(_ playerScore: PlayerScoreModel) throws {
        if highestScores.count == Self.amountOfTopScores {
            highestScores.sort()
            highestScores.removeLast()
        }
        highestScores.append(playerScore)
        let data = try playerScoresToData(highestScores)
        saveToUsersDefaults(data)
        try fetchHighestScores()
    }

    private func saveToUsersDefaults(_ data: Data) {
        UserDefaults.standard.set(data, forKey: Self.scoresKey)
    }

    private func retrieveFromUserDefaults() throws -> [PlayerScoreModel]? {
        if let data = UserDefaults.standard.data(forKey: Self.scoresKey) {
            let decoder = JSONDecoder()
            do {
                let questions = try decoder.decode([PlayerScoreModel].self, from: data)
                return questions
            } catch {
                throw ServiceError.parsingFailed
            }
        } else {
            return []
        }
    }

    private func playerScoresToData(_ playerScores: [PlayerScoreModel]) throws -> Data {
        do {
            let data = try JSONEncoder().encode(playerScores)
            return data
        } catch {
            throw ServiceError.invalidData
        }
    }
}
