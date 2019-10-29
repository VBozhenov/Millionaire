//
//  SessionCaretaker.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 29.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

final class SessionCaretaker {
    
    // MARK: - Preperties
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "session"
    
    // MARK: - Methods
    func save(session: GameSession) {
        do {
            let data = try self.encoder.encode(session)
            UserDefaults.standard.set(data,
                                      forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> GameSession {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return GameSession()
        }
        do {
            return try self.decoder.decode(GameSession.self,
                                           from: data)
        } catch {
            print(error)
            return GameSession()
        }
    }
}
