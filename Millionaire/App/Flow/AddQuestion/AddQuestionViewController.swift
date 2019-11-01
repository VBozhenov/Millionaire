//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 01.11.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var question: UITextField!
    @IBOutlet var answers: [UITextField]!
    @IBOutlet weak var correctAnswer: UITextField!
    
    // MARK: - Properties
    private var questionsCaretaker =  QuestionsCaretaker()
    private var questions: [Question]?
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)

        questions = try? questionsCaretaker.loadCustomQuestions()
    }
    
    @objc func handleTap() {
      view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func backButtonWasPressed(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonWasPressed(_ sender: Any) {
        
        guard let questionText = question.text,
          let answerA = answers[0].text,
          let answerB = answers[1].text,
          let answerC = answers[2].text,
          let answerD = answers[3].text,
          let correctAnswer = Int(correctAnswer.text ?? "") else { return }
        let question = Question(question: questionText,
                                answers: [answerA,
                                          answerB,
                                          answerC,
                                          answerD],
                                rightAnswer: correctAnswer)
        
        questions?.append(question)
        try? questionsCaretaker.saveCustomQuestions(questions ?? [])
        dismiss(animated: true, completion: nil)
    }
}
