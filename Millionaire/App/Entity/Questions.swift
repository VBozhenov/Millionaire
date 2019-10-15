//
//  Questions.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation

struct Questions {
    
    var questions: [Question]
    
    init() {
        self.questions = [Question(question: "Как заканчивается присказка: Мы и сами с...?",
                                   answers: ["с волосами",
                                             "с усами",
                                             "с часами",
                                             "с долгами"],
                                   rightAnswer: 2),
                          Question(question: "Как в обиходе называют растение, которое часто дарят женщинам к празднику 8 марта?",
                                   answers: ["оливье",
                                             "винегрет",
                                             "мимоза",
                                             "селёдка под шубой"],
                                   rightAnswer: 3),
                          Question(question: "С помощью чего пасссажиры часто попадают в самолет?",
                                   answers: ["рукава",
                                             "воротника",
                                             "лацкана",
                                             "манжеты"],
                                   rightAnswer: 1),
                          Question(question: "Как называлась песня, которую исполнял Лев Лещенко?",
                                   answers: ["Воробьиная стая",
                                             "Соловьиная роща",
                                             "Ласточкино гнездо",
                                             "Воронья слободка"],
                                   rightAnswer: 2),
                          Question(question: "Какой клетки нет на шахматной доске?",
                                   answers: ["h8",
                                             "b7",
                                             "k6",
                                             "g5"],
                                   rightAnswer: 3)]
    }
}
