//
//  QuestionsOrderStrategy.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 29.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

protocol QuestionsOrderStrategy: AnyObject {
    
    func chooseOrderOfQuestions(from questions: [Question]) -> [Question]
}
