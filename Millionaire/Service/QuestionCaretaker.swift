//
//  QuestionCaretaker.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 01.11.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

final class QuestionsCaretaker {
    
    // MARK: - Preperties
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let customQuestionsKey = "customQuestions"
    
    // MARK: - Methods
    func saveCustomQuestions(_ questions: [Question]) throws {
        let data = try self.encoder.encode(questions)
        UserDefaults.standard.set(data, forKey: self.customQuestionsKey)
    }
    
    func loadCustomQuestions() throws -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: self.customQuestionsKey) else {
            return []
        }
        return try self.decoder.decode([Question].self, from: data)
    }
    
}
