//
//  UIView+extansion.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 13.10.2023.
//

import Foundation
import UIKit

extension UIButton {
    func fontInstall(textButton: String, fontName: String, size: CGFloat) -> NSAttributedString {
        if let customFont = UIFont(name: fontName, size: size) {
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: customFont]
            return NSAttributedString(string: textButton, attributes: attributes)
        } else {
            return NSAttributedString(string: textButton, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)])
        }
    }
}
extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
}

extension UIButton {
    func dropShadowButton() {
        layer.masksToBounds = false
               layer.shadowColor = UIColor.black.cgColor
               layer.shadowOpacity = 0.5
               layer.shadowOffset = CGSize(width: 0, height: 10) // Adjust the offset to your preference
               layer.shadowRadius = 10 // Adjust the radius to your preference
               layer.shouldRasterize = true
    }
}

extension UIView {
    func rounded (radius : CGFloat = 15) {
        self.layer.cornerRadius = radius
    }
    
    func addGradient() {
            let gradient = CAGradientLayer()
            
            gradient.colors = [UIColor.white.cgColor, UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.blue.cgColor]
            gradient.opacity = 0.6
            gradient.startPoint = CGPoint(x: 0.3, y: 0.9)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            
            gradient.frame = self.bounds
            self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UserDefaults {
    /*
     func set<T: Encodable>(encodable: T, forKey key: String) {
     if let data = try? JSONEncoder().encode(encodable) {
     set(data, forKey: key)
     }
     }
     
     func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
     if let data = object(forKey: key) as? Data,
     let value = try? JSONDecoder().decode(type, from: data) {
     return value
     }
     return nil
     }
     }
     */
    func set<T: Encodable>(encodable: T, forKey key: String, from userDefaults: UserDefaults = .standard) {
        if let data = try? JSONEncoder().encode(encodable) {
            userDefaults.set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String, from userDefaults: UserDefaults = .standard) -> T? {
        if let data = userDefaults.object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
  
//let font = UIFont(name: "GhastlyPanicCyrRegular", size: 30)
  //      labelText.font = font
        
        
    //    ButtonLabel.backgroundColor = .red
        
 //       let textButton = "dsfdsfdsf"
   //     let attributes1: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 50)]
     //   let attributedString = NSAttributedString(string: textButton, attributes: attributes1)
     //   ButtonLabel.setAttributedTitle(attributedString, for: .normal)
