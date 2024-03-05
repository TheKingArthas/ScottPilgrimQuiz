//
//  QuestionService.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 5/3/24.
//

import Foundation

struct QuestionService {
    func fetchQuestions() throws -> [QuestionModel] {
        let fileURL = try localJsonFileUrl()
        let localJsonData = try readLocalJsonFile(fileUrl: fileURL)
        let questions = try parseJSONData(data: localJsonData)
        return questions
    }
    
    private func localJsonFileUrl() throws -> URL {
        let localJsonFileName = "ScottPilgrimQuizJsonResponse"
        guard let fileUrl = Bundle.main.url(forResource: localJsonFileName, withExtension: "json") else {
            print("Couldn't find \(localJsonFileName).json in the main bundle.")
            throw ServiceError.invalidFilePath
        }
        return fileUrl
    }
    
    private func readLocalJsonFile(fileUrl: URL) throws -> Data {
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            return jsonData
        } catch {
            print("Error reading JSON file:", error.localizedDescription)
            throw ServiceError.invalidData
        }
    }
    
    private func parseJSONData(data: Data) throws -> [QuestionModel] {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([QuestionModel].self, from: data)
        } catch {
            print("Error parsing JSON data:", error.localizedDescription)
            throw ServiceError.parsingFailed
        }
    }
}
