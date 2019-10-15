//
//  GameSession.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

class GameSession {
    
    // MARK: - Properties
    var totalQuestions: Int = 0
    var currentQuestion: Int = 0
    var correctAnswers: Int = 0
    var percentOfCorrectAnswers: Int = 0
}

// MARK: - GameViewControllerDelegate
extension GameSession: GameViewControllerDelegate {
    func answeredCorrect() {
        correctAnswers += 1
        calculatePercentOfQuestionsAnswered()
    }
    
    func calculatePercentOfQuestionsAnswered() {
      guard totalQuestions != 0 else { return }
      let ratioAnsweredToNonAnswered: Float = Float(correctAnswers) / Float(totalQuestions)
      percentOfCorrectAnswers = Int(ratioAnsweredToNonAnswered * 100)
    }
    
    func gameEnded() {
        Game.shared.gameEnded(with: percentOfCorrectAnswers)
    }
    
    
}
