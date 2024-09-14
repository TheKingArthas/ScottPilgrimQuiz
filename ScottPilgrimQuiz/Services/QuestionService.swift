//
//  QuestionService.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

struct QuestionService {
    static private let questionsKey = "questions"

    func fetchQuestions() throws -> [QuestionModel] {
        let fileURL = try localJsonFileUrl()
        let retrievedJsonData = try readLocalJsonFile(fileUrl: fileURL)
        let retrievedQuestions = try parseJSONData(data: retrievedJsonData)

        if let persistedQuestions = retrieveFromUserDefaults(),
           persistedQuestions.version >= retrievedQuestions.version {
            return persistedQuestions.questions
        } else {
            saveToUsersDefaults(retrievedJsonData)
            return retrievedQuestions.questions
        }
    }

    private func saveToUsersDefaults(_ data: Data) {
        UserDefaults.standard.set(data, forKey: Self.questionsKey)
    }

    private func retrieveFromUserDefaults() -> QuestionsModel? {
        if let data = UserDefaults.standard.data(forKey: Self.questionsKey) {
            let decoder = JSONDecoder()
            do {
                let questions = try decoder.decode(QuestionsModel.self, from: data)
                return questions
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
            }
        }
        return nil
    }
}

extension QuestionService {
    private func readLocalJsonFile(fileUrl: URL) throws -> Data {
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            return jsonData
        } catch {
            print("Error reading JSON file:", error.localizedDescription)
            throw ServiceError.invalidData
        }
    }

    private func localJsonFileUrl() throws -> URL {
        let localJsonFileName = "ScottPilgrimQuizJsonResponse"
        guard let fileUrl = Bundle.main.url(forResource: localJsonFileName, withExtension: "json") else {
            print("Couldn't find \(localJsonFileName).json in the main bundle.")
            throw ServiceError.invalidFilePath
        }
        return fileUrl
    }

    private func parseJSONData(data: Data) throws -> QuestionsModel {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(QuestionsModel.self, from: data)
        } catch {
            print("Error parsing JSON data:", error.localizedDescription)
            throw ServiceError.parsingFailed
        }
    }
}
