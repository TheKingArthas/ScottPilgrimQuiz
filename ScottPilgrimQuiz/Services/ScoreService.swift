//
//  ScoreService.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 3/11/24.
//

import Foundation

class ScoreService {
    static private let scoresKey = "questions"

    private(set) var highestScores: [PlayerScore] = []

    func fetchHighestScores() {
        highestScores = retrieveFromUserDefaults() ?? []
    }

    func isInTopScores(_ playerScore: PlayerScore) -> Bool {
        highestScores.contains(where: { playerScore.score > $0.score })
    }

    func addScore(_ playerScore: PlayerScore) throws {
        highestScores.sort()
        highestScores.removeLast()
        highestScores.append(playerScore)
        let data = try playerScoresToData(highestScores)
        saveToUsersDefaults(data)
    }

    private func saveToUsersDefaults(_ data: Data) {
        UserDefaults.standard.set(data, forKey: Self.scoresKey)
    }

    private func retrieveFromUserDefaults() -> [PlayerScore]? {
        if let data = UserDefaults.standard.data(forKey: Self.scoresKey) {
            let decoder = JSONDecoder()
            do {
                let questions = try decoder.decode([PlayerScore].self, from: data)
                return questions
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
            }
        }
        return nil
    }

    private func playerScoresToData(_ playerScores: [PlayerScore]) throws -> Data {
        do {
            let data = try JSONEncoder().encode(playerScores)
            return data
        } catch {
            print("Error parsing to data:", error.localizedDescription)
            throw ServiceError.invalidData
        }
    }
}
