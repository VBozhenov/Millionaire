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
    private let resultCaretaker = ResultCaretaker()
    private(set) var gameResults: [GameResult] {
        didSet {
            resultCaretaker.save(gameResults: self.gameResults)
        }
    }
    var questionsOrder: QuestionsOrder
    
    private init() {
        self.gameResults = self.resultCaretaker.retrieveResults()
        self.questionsOrder = .straight
    }
    
    // MARK: - Methods
    func gameDidEnd(with percentOfCorrectAnswers: Int) {
        let currentDate = Date()
        let newHighScore = GameResult(date: currentDate,
                                      percentOfCorrectAnswers: percentOfCorrectAnswers)
        gameResults.append(newHighScore)
        gameSession = nil
    }
}
