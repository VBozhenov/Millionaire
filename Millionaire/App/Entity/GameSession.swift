//
//  GameSession.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

class GameSession {
    
    // MARK: - Properties
    var totalQuestions: Int = 0
    var currentQuestion: Observable<Int> = Observable(0)
    var correctAnswers: Int = 0
    var percentOfCorrectAnswers: Observable<Int> = Observable(0)
    var isFiftyFifty: Bool = true
    var isCallFriend: Bool = true
    var isAudienceHelp: Bool = true
    
    // MARK: - Methods
    private func calculatePercentOfCorrectAnswers() {
        guard totalQuestions != 0 else { return }
        percentOfCorrectAnswers.value = Int(Double(correctAnswers) / Double(totalQuestions) * 100)
    }
}

// MARK: - GameViewControllerDelegate
extension GameSession: GameViewControllerDelegate {
    
    func answeredCorrect() {
        correctAnswers += 1
        currentQuestion.value += 1
        calculatePercentOfCorrectAnswers()
    }
    
    func gameOver() {
        Game.shared.gameDidEnd(with: percentOfCorrectAnswers.value)
    }
}
