//
//  GameViewController.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 14.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate: class {
    var totalQuestions: Int { get set }
    func answeredCorrect()
    func gameEnded()
}

class GameViewController: UIViewController {
    
    // MARK: - Properties
    weak var gameDelegate: GameViewControllerDelegate?
    let questions = Questions().questions
    private var currentQuestionNumber = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButton: [UIButton]!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.gameSession = GameSession()
        gameDelegate = Game.shared.gameSession
        gameDelegate?.totalQuestions = questions.count
        updateView(with: questions[currentQuestionNumber])
    }
    
    // MARK: - Methods
    func updateView(with question: Question) {
        answerButton.forEach { (button) in
            button.setButtonStyle(with: .blue)
        }
        questionLabel.setLabelStyle(with: .blue)
        
        for buttonIndex in 0..<answerButton.count {
        answerButton[buttonIndex].setTitle(question.answers[buttonIndex],
                                           for: .normal)
        }
        questionLabel.text = question.question
        totalQuestionsLabel.text = "\(Game.shared.gameSession?.totalQuestions ?? 0)"
        correctAnswersLabel.text = "\(Game.shared.gameSession?.percentOfCorrectAnswers ?? 0)"
    }
    
    // MARK: - IBActions
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        if sender.tag == questions[currentQuestionNumber].rightAnswer &&
            currentQuestionNumber < questions.count - 1 {
            gameDelegate?.answeredCorrect()
            currentQuestionNumber += 1
            updateView(with: questions[currentQuestionNumber])
        } else {
            gameDelegate?.gameEnded()
            self.dismiss(animated: true)
        }
    }
}

