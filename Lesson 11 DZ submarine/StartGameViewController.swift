//
//  StartGameViewController.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 04.10.2023.
//

import UIKit

class StartGameViewController: UIViewController {

    @IBOutlet weak var StartGameButton: UIButton!
    
    @IBOutlet weak var recordsButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        StartGameButton.dropShadowButton()
        recordsButton.dropShadowButton()
        settingButton.dropShadowButton()
        
        let attr = StartGameButton.fontInstall(textButton: "Start Game", fontName: "YahooCBold", size: 30)
        
        StartGameButton.setAttributedTitle(attr, for: .normal)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)

        backgroundImage.image = UIImage(named: "StartLogo")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    @IBAction func startGameButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RecordsViewController") as! RecordsViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    



}
