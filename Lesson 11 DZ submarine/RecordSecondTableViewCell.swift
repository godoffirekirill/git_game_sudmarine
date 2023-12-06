//
//  RecordSecondTableViewCell.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 13.11.2023.
//

import UIKit

class RecordSecondTableViewCell: UITableViewCell {
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var fourLabel: UILabel!
    
    
    func configureSecond(with text: [String]) {
       
        firstLabel.text = text[0]
        secondLabel.text = text[1]
        thirdLabel.text = text[2]
        fourLabel.text = text[3]
    
        
    }

}
