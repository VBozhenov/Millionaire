//
//  Game.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

final class Game {
    
    // MARK: - Properties
    static let shared = Game()
    var gameSession: GameSession?
    var gameResults: [GameResult] = []
    
    private init() { }
    
    // MARK: - Methods
    func gameDidEnd(with percentOfCorrectAnswers: Int) {
        let currentDate = Date()
        let newHighScore = GameResult(date: currentDate,
                                      percentOfCorrectAnswers: percentOfCorrectAnswers)
        print(newHighScore)
        gameResults.append(newHighScore)
        gameSession = nil
    }
}
