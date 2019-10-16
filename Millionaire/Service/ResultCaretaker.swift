//
//  ResultCaretaker.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 16.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

final class ResultCaretaker {
    
    // MARK: - Preperties
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "records"
    
    // MARK: - Methods
    func save(gameResults: [GameResult]) {
        do {
            let data = try self.encoder.encode(gameResults)
            UserDefaults.standard.set(data,
                                      forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> [GameResult] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([GameResult].self,
                                           from: data)
        } catch {
            print(error)
            return []
        }
    }
}
