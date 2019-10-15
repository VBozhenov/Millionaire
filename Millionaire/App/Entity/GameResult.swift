//
//  GameResult.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation
struct GameResult: Codable {
    
    // MARK: - Properties
    let date: Date
    let percentOfCorrectAnsvers: Int
}
