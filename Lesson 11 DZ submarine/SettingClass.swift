//
//  SettingClass.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 21.10.2023.
//

import Foundation

class Setting: Codable, Equatable {
    var currentSubmarineIndex : Int
    var nameuser : String
    var selectedSpeedKey : String
    var howMuchIsTheFish : Int

    
    
    init(currentSubmarineIndex: Int, nameuser: String, selectedSpeedKey: String, howMuchIsTheFish: Int) {
        self.currentSubmarineIndex = currentSubmarineIndex
        self.nameuser = nameuser
        self.selectedSpeedKey = selectedSpeedKey
        self.howMuchIsTheFish = howMuchIsTheFish
    }
    
    
    static func ==(lhs: Setting, rhs: Setting) -> Bool {
            return lhs.currentSubmarineIndex == rhs.currentSubmarineIndex &&
                   lhs.nameuser == rhs.nameuser &&
                   lhs.selectedSpeedKey == rhs.selectedSpeedKey &&
                   lhs.howMuchIsTheFish == rhs.howMuchIsTheFish
        }
    static func defaultSettings() -> Setting? {
        return Setting(
            currentSubmarineIndex: 0,
            nameuser: "DefaultName",
            selectedSpeedKey: "Low",
            howMuchIsTheFish: 0
        )
    }


    
    func description() -> String {
          return "Current Submarine Index: \(currentSubmarineIndex)\n" +
                 "Name User: \(nameuser)\n" +
                 "Speed Level: \(selectedSpeedKey)\n" +
                 "How Much Is The Fish: \(howMuchIsTheFish)"
      }
    
    

}
