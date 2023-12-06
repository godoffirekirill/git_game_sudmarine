//
//  SettingManager.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 21.10.2023.
//


import Foundation
import UIKit
class Manager {
    static let shared = Manager()
    
        var submarineImage = ["submarine.ellow", "submarine-red", "submarine-fastfouris", "submarine-gray","submarineExplosion"]
        var fishImages = ["fishOneFinal","fishTwoFinal"]
    var speedLevels: [String: CGFloat] = [
        "Low": 0.3,
        "Medium": 0.6,
        "Hard": 1.0
    ]
    var howMuchIsTheFishNumber = ["1","2","3"]
    
    var safeRecords: [[String: Any]] = []
    
    func saveSetting(_ setting: Setting) {
          UserDefaults.standard.set(encodable: setting, forKey: "settingConfig")
      }

      func loadSetting() -> Setting? {
          return UserDefaults.standard.value(Setting.self, forKey: "settingConfig")
      }
    
    func recordDate(_ gameresult: Setting) {
        
        UserDefaults.standard.set(encodable: gameresult, forKey: "gameStartTime")
    }
    func loadDate() -> GameResult? {
        return UserDefaults.standard.value(GameResult.self, forKey: "gameStartTime")
    }
   
}




