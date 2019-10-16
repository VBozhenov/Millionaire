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
    var isFiftyFifty: Bool { get set }
    var isCallFriend: Bool { get set }
    var isAudienceHelp: Bool { get set }
    func answeredCorrect()
    func gameOver()
}

class GameViewController: UIViewController {
    
    // MARK: - Properties
    private var alert = Alert()
    weak var gameDelegate: GameViewControllerDelegate?
    private let questions = Questions().questions
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButton: [UIButton]!
    @IBOutlet var hintButtons: [UIButton]!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDelegate = Game.shared.gameSession
        gameDelegate?.totalQuestions = questions.count
        updateView(with: questions[gameDelegate?.currentQuestion ?? 0])
    }
    
    // MARK: - Methods
    private func setViewAppearence() {
        answerButton.forEach {
            $0.setStyle()
            $0.isEnabled = true
            $0.alpha = 1
        }
        questionLabel.setStyle()
        hintButtons.forEach { $0.setStyle() }
    }
    
    private func updateView(with question: Question) {
        setViewAppearence()
        answerButton.forEach {
            $0.setTitle(question.answers[$0.tag],
                        for: .normal)
        }
        questionLabel.text = question.question
    }
    
    private func fiftyFifty() {
        guard let gameDelegate = gameDelegate else { return }
        let correctAnswerIndex = questions[gameDelegate.currentQuestion].rightAnswer - 1
        let arrayOfIndexes = Array(0..<questions[gameDelegate.currentQuestion].answers.count)
        let randomIndex = Int.random(in: 0..<(arrayOfIndexes.count - 1))
        var wrongIndexes = arrayOfIndexes.filter { $0 != correctAnswerIndex }
        wrongIndexes.remove(at: randomIndex)
        _ = wrongIndexes.map {
            answerButton[$0].isEnabled = false
            answerButton[$0].alpha = 0.5
        }
    }
    
    private func audienceHelp() {
        guard let gameDelegate = gameDelegate else { return }
        let correctAnswerIndex = questions[gameDelegate.currentQuestion].rightAnswer - 1
        var percentageLeft = 70
        answerButton
            .filter { $0.tag != correctAnswerIndex }
            .forEach {
                let answerPersentage = Int.random(in: 0 ... percentageLeft)
                percentageLeft -= answerPersentage
                $0.setTitle(($0.titleLabel?.text ?? "") + " - \(answerPersentage) %",
                    for: .normal) }
        answerButton[correctAnswerIndex].setTitle((answerButton[correctAnswerIndex].titleLabel?.text ?? "") + " - \(percentageLeft + 30) %",
            for: .normal)
    }
    
    private func callFriend() {
        guard let gameDelegate = gameDelegate else { return }
        let correctAnswerIndex = questions[gameDelegate.currentQuestion].rightAnswer - 1
        let randomNumber = Int.random(in: 0 ... (questions[gameDelegate.currentQuestion].answers.count - 1) * 2)
        let friendsAnsver = randomNumber <= questions[gameDelegate.currentQuestion].answers.count - 1 ? randomNumber : correctAnswerIndex
        answerButton[friendsAnsver].backgroundColor = .green
    }
    
    // MARK: - IBActions
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let gameDelegate = gameDelegate else { return }
        if sender.tag != questions[gameDelegate.currentQuestion].rightAnswer - 1 {
            gameDelegate.gameOver()
            alert.showAlertWith(title: "СОЖАЛЕЮ",
                                message: "Вы проиграли!",
                                in: self)
        } else if gameDelegate.currentQuestion < questions.count - 1 {
            gameDelegate.answeredCorrect()
            updateView(with: questions[gameDelegate.currentQuestion])
        } else {
            gameDelegate.answeredCorrect()
            gameDelegate.gameOver()
            alert.showAlertWith(title: "ПОЗДРАВЛЯЮ!!!",
                                message: "Вы выйграли!",
                                in: self)
        }
    }
    
    @IBAction func hintButtonTapped(_ sender: UIButton) {
        hintButtons[sender.tag].isEnabled = false
        switch sender.tag {
        case 0:
            gameDelegate?.isFiftyFifty = false
            fiftyFifty()
        case 1:
            gameDelegate?.isAudienceHelp = false
            audienceHelp()
        case 2:
            gameDelegate?.isCallFriend = false
            callFriend()
        default:
            break
        }
    }
}

