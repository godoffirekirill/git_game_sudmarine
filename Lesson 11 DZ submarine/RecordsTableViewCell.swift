//
//  RecordsTableViewCell.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 13.11.2023.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainFirstLabel: UILabel!
    @IBOutlet weak var mainSecondLabel: UILabel!
    @IBOutlet weak var mainThirdLabel: UILabel!
    @IBOutlet weak var mainFourLabel: UILabel!
    
    func configure(with gameData: [String: Any]) {
        if let date = gameData["Date"] as? String {
            mainFirstLabel.text = "Date: \(date)"
        }

        if let userName = gameData["UserName"] as? String {
            mainSecondLabel.text = "User: \(userName)"
        }

        if let difficulty = gameData["difficulty"] as? String {
                mainThirdLabel.text = "Difficulty: \(difficulty)"
                print(difficulty)
            }

        if let score = gameData["Score"] as? Int {
            mainFourLabel.text = "Score: \(score)"
        }
    }
}

