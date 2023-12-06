//
//  DateClass.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 13.11.2023.
//

import Foundation

class GameResult: Codable, Equatable {
    static func == (lhs: GameResult, rhs: GameResult) -> Bool {
        return lhs.startTime == lhs.startTime
    }
    
    var startTime: Date

    init(startTime: Date) {
        self.startTime = startTime
    }

}
