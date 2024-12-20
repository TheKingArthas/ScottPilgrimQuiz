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
        let questionnaireModel = try parseJSONDataToQuestionnaireModel(retrievedJsonData)
        return questionnaireModel.questions
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

    private func parseJSONDataToQuestionnaireModel(_ data: Data) throws -> QuestionnaireModel {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(QuestionnaireModel.self, from: data)
        } catch {
            print("Error parsing JSON data:", error.localizedDescription)
            throw ServiceError.parsingFailed
        }
    }
}
