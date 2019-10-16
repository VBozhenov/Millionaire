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
    var percentOfCorrectAnswers: Int { get set }
    var currentQuestion: Int { get set }
    func answeredCorrect()
    func gameOver()
}

class GameViewController: UIViewController {
    
    // MARK: - Properties
    weak var gameDelegate: GameViewControllerDelegate?
    private let questions = Questions().questions
    private var currentQuestionNumber = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButton: [UIButton]!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearence()
        gameDelegate = Game.shared.gameSession
        gameDelegate?.totalQuestions = questions.count
        updateView(with: questions[currentQuestionNumber])
    }
    
    // MARK: - Methods
    private func setViewAppearence() {
        answerButton.forEach { (button) in
            button.setStyle()
        }
        questionLabel.setStyle()
    }
    
    private func updateView(with question: Question) {
        for buttonIndex in 0..<answerButton.count {
            answerButton[buttonIndex].setTitle(question.answers[buttonIndex],
                                               for: .normal)
        }
        questionLabel.text = question.question
        guard let gameDelegate = gameDelegate else { return }
        totalQuestionsLabel.text = "\(gameDelegate.totalQuestions)"
        correctAnswersLabel.text = "\(gameDelegate.percentOfCorrectAnswers)"
    }
    
    // MARK: - IBActions
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let gameDelegate = gameDelegate else { return }
        if sender.tag != questions[currentQuestionNumber].rightAnswer {
            gameDelegate.gameOver()
            self.dismiss(animated: true)
        } else if currentQuestionNumber < questions.count - 1 {
            gameDelegate.answeredCorrect()
            currentQuestionNumber = gameDelegate.currentQuestion
            updateView(with: questions[currentQuestionNumber])
        } else {
            gameDelegate.answeredCorrect()
            gameDelegate.gameOver()
            self.dismiss(animated: true)
        }
    }
}

