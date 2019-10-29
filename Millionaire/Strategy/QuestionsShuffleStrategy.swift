//
//  QuestionsShuffleStrategy.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 29.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

class QuestionsShuffleStrategy: QuestionsOrderStrategy {
    
    func chooseOrderOfQuestions(from questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
