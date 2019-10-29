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
    var percentOfCorrectAnswers: Observable<Int> { get set }
    var currentQuestion: Observable<Int> { get set }
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
    private var questions = Questions().questions
    var questionStrategy: QuestionsOrderStrategy?
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet var hintButtons: [UIButton]!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var correctAnswersPersentageLabel: UILabel!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDelegate = Game.shared.gameSession
        gameDelegate?.totalQuestions = questions.count
        switch Game.shared.questionsOrder  {
        case .straight :
            questionStrategy = QuestionsStraightStrategy()
        case .shuffle:
            questionStrategy = QuestionsShuffleStrategy()
        }
        questions = questionStrategy?.chooseOrderOfQuestions(from: questions) ?? questions
        gameDelegate?.percentOfCorrectAnswers.addObserver(self, options: [.new, .initial], closure: { [weak self] (percentage, _) in self?.correctAnswersPersentageLabel.text = "\(percentage)%" })
        gameDelegate?.currentQuestion.addObserver(self, options: [.new, .initial], closure: { [weak self] (question, _) in self?.questionNumberLabel.text = "\(question + 1)" })
        updateView(with: questions[gameDelegate?.currentQuestion.value ?? 0])
    }
    
    // MARK: - Methods
    private func setViewAppearence() {
        answerButtons.forEach {
            $0.setStyle()
            $0.isEnabled = true
            $0.alpha = 1
        }
        questionLabel.setStyle()
        hintButtons.forEach { $0.setStyle() }
    }
    
    private func updateView(with question: Question) {
        setViewAppearence()
        answerButtons.forEach {
            $0.setTitle(question.answers[$0.tag],
                        for: .normal)
        }
        questionLabel.text = question.question
        hintButtons[0].isEnabled = gameDelegate?.isFiftyFifty ?? true
        hintButtons[1].isEnabled = gameDelegate?.isAudienceHelp ?? true
        hintButtons[2].isEnabled = gameDelegate?.isCallFriend ?? true
    }
    
    private func fiftyFifty() {
        guard let gameDelegate = gameDelegate else { return }
        let correctAnswerIndex = questions[gameDelegate.currentQuestion.value].rightAnswer - 1
        let arrayOfIndexes = Array(0..<questions[gameDelegate.currentQuestion.value].answers.count)
        let randomIndex = Int.random(in: 0..<(arrayOfIndexes.count - 1))
        var wrongIndexes = arrayOfIndexes.filter { $0 != correctAnswerIndex }
        wrongIndexes.remove(at: randomIndex)
        _ = wrongIndexes.map {
            answerButtons[$0].isEnabled = false
            answerButtons[$0].alpha = 0.5
        }
    }
    
    private func audienceHelp() {
        guard let gameDelegate = gameDelegate else { return }
        let correctAnswerIndex = questions[gameDelegate.currentQuestion.value].rightAnswer - 1
        var percentageLeft = 70
        answerButtons
            .filter { $0.tag != correctAnswerIndex }
            .forEach {
                let answerPersentage = Int.random(in: 0 ... percentageLeft)
                percentageLeft -= answerPersentage
                $0.setTitle(($0.titleLabel?.text ?? "") + " - \(answerPersentage) %",
                    for: .normal) }
        answerButtons[correctAnswerIndex].setTitle((answerButtons[correctAnswerIndex].titleLabel?.text ?? "") + " - \(percentageLeft + 30) %",
            for: .normal)
    }
    
    private func callFriend() {
        guard let gameDelegate = gameDelegate else { return }
        let correctAnswerIndex = questions[gameDelegate.currentQuestion.value].rightAnswer - 1
        let randomNumber = Int.random(in: 0 ... (questions[gameDelegate.currentQuestion.value].answers.count - 1) * 2)
        let friendsAnsver = randomNumber <= questions[gameDelegate.currentQuestion.value].answers.count - 1 ? randomNumber : correctAnswerIndex
        answerButtons[friendsAnsver].backgroundColor = .green
    }
    
    // MARK: - IBActions
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let gameDelegate = gameDelegate else { return }
        if sender.tag != questions[gameDelegate.currentQuestion.value].rightAnswer - 1 {
            gameDelegate.gameOver()
            alert.showAlertWith(title: "СОЖАЛЕЮ",
                                message: "Вы проиграли!",
                                in: self)
        } else if gameDelegate.currentQuestion.value < questions.count - 1 {
            gameDelegate.answeredCorrect()
            updateView(with: questions[gameDelegate.currentQuestion.value])
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

