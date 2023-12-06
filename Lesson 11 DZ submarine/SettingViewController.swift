//
//  SettingViewController.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 04.10.2023.
//


import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var nowNameUsed: UILabel!
    
    @IBOutlet weak var enterNameLabel: UILabel!
    
    @IBOutlet weak var enterNameText: UITextField!
    
    @IBOutlet weak var selectSubmarine: UIImageView!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var speedSelectLabel: UILabel!
    
    @IBOutlet weak var howMuchIsTheFish: UILabel!
    
    @IBOutlet weak var howMuchIsTheFishSelect: UILabel!
    
  //  var submarineImage = ["submarine.ellow", "submarine-red", "submarine-fastfouris", "submarine-gray","submarineExplosion"]
    var submarineIndex = 0
    var submarineImage = Manager.shared.submarineImage
   
    
  //  var speedLavel = ["Low", "Medium","Hard"]
    var speedLabelIndex = 0
 
    var speedLevels = Manager.shared.speedLevels
    var selectedSpeedKey: String = "Low" // Default speed level

    
    var howMuchIsTheFishNumber = Manager.shared.howMuchIsTheFishNumber
    var howMuchIsTheFishIndex = 0
    var loadedSettings: Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let labelFont = UIFont(name: "YahooCBold", size: 12)
        
        enterNameLabel.font = labelFont
        enterNameLabel.text = "Enter New Name"
        speedLabel.font = labelFont
        speedLabel.text = "Speed"
        howMuchIsTheFish.font = labelFont
        howMuchIsTheFish.text = "How much is the fish"
        nowNameUsed.font = labelFont
        enterNameText.font = labelFont
        speedSelectLabel.font = labelFont
        howMuchIsTheFishSelect.font = labelFont
        speedSelectLabel.text = "Low"
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)

        backgroundImage.image = UIImage(named: "StartLogo")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
      //  displayImage(submarineImage[submarineIndex])
        changeUserName()
      //  displaySpeed(speedLavel, at: howMuchIsTheFishIndex)
      //  updateSpeedLabel()
        
            
        displayImage(submarineImage, at: submarineIndex)
        displayFish(howMuchIsTheFishNumber, at: howMuchIsTheFishIndex)
        loadSetting()
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let settingConfig = Setting(
               currentSubmarineIndex: submarineIndex,
               nameuser: nowNameUsed.text ?? "DefaultName",
               selectedSpeedKey: selectedSpeedKey,
               howMuchIsTheFish: howMuchIsTheFishIndex
           )
       // guard let username = UserDefaults.standard.value(forKey: "username") as? String else { return }
      //  nowNameUsed.text = username
        if settingConfig != self.loadedSettings {
          //  print(settingConfig.description())
            UserDefaults.standard.set(encodable: settingConfig, forKey: "settingConfig")
        }
        

    }
    @IBAction func leftButtonFirstPressed(_ sender: UIButton) {
       // submarineIndex += 1 // индекс принимает значение +1 по каждому нажатию
        if submarineIndex >= submarineImage.count {
            submarineIndex = 0
            
        }
        slideImages(fromRight: true)
    }
    @IBAction func leftButtonSecondPressed(_ sender: UIButton) {
        speedLabelIndex -= 1
        if speedLabelIndex < 0 {
            speedLabelIndex = speedLevels.count - 1
        }
        updateSpeedLabel()
        selectedSpeedKey = Array(speedLevels.keys)[speedLabelIndex]

    }
    @IBAction func leftButtonThirdPressed(_ sender: UIButton) {
        howMuchIsTheFishIndex -= 1
        if howMuchIsTheFishIndex < 0 {
            howMuchIsTheFishIndex = howMuchIsTheFishNumber.count - 1
        }
        
        howMuchIsTheFishSelect.text = howMuchIsTheFishNumber[howMuchIsTheFishIndex]
    }
    @IBAction func rightButtonFirstPressed(_ sender: UIButton) {
       // submarineIndex -= 1
        if submarineIndex < 0 {
            submarineIndex = submarineImage.count - 1
        }
        slideImages(fromRight: false)
    }
    
    @IBAction func rightButtonSecondPressed(_ sender: UIButton) {
      
        speedLabelIndex += 1
            if speedLabelIndex >= speedLevels.count {
                speedLabelIndex = 0
            }
            updateSpeedLabel()
        selectedSpeedKey = Array(speedLevels.keys)[speedLabelIndex]

    }
    @IBAction func rightButtonThirdPressed(_ sender: UIButton) {
        howMuchIsTheFishIndex += 1
        if howMuchIsTheFishIndex >= howMuchIsTheFishNumber.count {
            howMuchIsTheFishIndex = 0
        }
        howMuchIsTheFishSelect.text = howMuchIsTheFishNumber[howMuchIsTheFishIndex]
    }
    @IBAction func saveNameButtonPressed(_ sender: UIButton) {
        changeUserName()
    }
    
    func slideImages(fromRight: Bool) {
        var nextImageIndex = submarineIndex + (fromRight ? 1 : -1)

        if nextImageIndex >= submarineImage.count {
            nextImageIndex = 0 // Wrap around to the first image
        } else if nextImageIndex < 0 {
            nextImageIndex = submarineImage.count - 1 // Wrap around to the last image
        }

        let nextImageName = submarineImage[nextImageIndex]

        UIView.transition(with: selectSubmarine, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.selectSubmarine.image = UIImage(named: nextImageName)
        }, completion: nil)

        submarineIndex = nextImageIndex // Update the submarineIndex
    }


    func displayImage(_ submarineImage: [String], at submarineIndex: Int) {
        if submarineIndex >= 0 && submarineIndex < submarineImage.count {
            selectSubmarine.image = UIImage(named: submarineImage[submarineIndex])
        }
    }
/*    func displaySpeed(_ speedLavel: [String], at speedLabelIndex: Int) {
        if speedLabelIndex >= 0 && speedLabelIndex < speedLavel.count {
            speedSelectLabel.text = speedLavel[speedLabelIndex]
        } else {
            // Handle the case where the index is out of range.
            // You can set a default value or display an error message as needed.
            speedSelectLabel.text = "Invalid Index"
        }
    }
 */
    func displayFish(_ howMuchIsTheFishNumber: [String], at howMuchIsTheFishIndex: Int) {
        if howMuchIsTheFishIndex >= 0 && howMuchIsTheFishIndex < howMuchIsTheFishNumber.count {
            howMuchIsTheFishSelect.text = howMuchIsTheFishNumber[howMuchIsTheFishIndex]
        } else {
            // Handle the case where the index is out of range.
            // You can set a default value or display an error message as needed.
            howMuchIsTheFishSelect.text = "Invalid Index"
        }
    }
  

  //  displaySpeed(speedLavel, at: speedLabelIndex)

    func changeUserName() {
        let username = enterNameText.text
        
        if let username = username, username.isEmpty {
            nowNameUsed.text = "DefaultName" // Set your default name here
        } else {
            nowNameUsed.text = username
        }
        
    }
    func updateSpeedLabel() {
        let speedLevelKey = Array(speedLevels.keys)[speedLabelIndex]
        speedSelectLabel.text = speedLevelKey
      //  print("\(Array(speedLevels.keys)[speedLabelIndex])")
    }
    func loadSetting() {
        self.loadedSettings = UserDefaults.standard.value(Setting.self, forKey: "settingConfig")
        if let loadedSettings = self.loadedSettings {
            // Use the loadedSetting object as needed
            let loadedSubmarineIndex = loadedSettings.currentSubmarineIndex
            let loadedName = loadedSettings.nameuser
           // let loadedSpeedLevel = loadedSettings.currentspeedLabelIndex
            let loadedSelectedSpeedKey = loadedSettings.selectedSpeedKey

            let loadedHowMuchIsTheFishIndex = loadedSettings.howMuchIsTheFish
            selectedSpeedKey = loadedSelectedSpeedKey
            speedSelectLabel.text = loadedSelectedSpeedKey
            submarineIndex = loadedSubmarineIndex
            nowNameUsed.text = loadedSettings.nameuser
            selectSubmarine.image = UIImage(named: submarineImage[loadedSubmarineIndex])
            howMuchIsTheFishIndex = loadedHowMuchIsTheFishIndex
            howMuchIsTheFishSelect.text = howMuchIsTheFishNumber[loadedHowMuchIsTheFishIndex]

            
            
            
            /*   if let speedLabel = speedLevels.first(where: { $0.value == loadedSpeedLevel })?.key {
                      speedSelectLabel.text = speedLabel
                  } else {
                      // Handle the case where the speedLevel from the loadedSetting doesn't match any key in speedLevels
                      speedSelectLabel.text = "Low"
                  }
          */
            // Now you can use these loaded values in your code
         /*   print("Loaded Submarine Index: \(loadedSubmarineIndex)")
            print("Loaded Name: \(loadedName)")
            print("Loaded Speed Level: \(loadedSelectedSpeedKey)")
            print("Loaded How Much Is The Fish Index: \(loadedHowMuchIsTheFishIndex)") */
         //   self.loadedSettings = Setting(currentSubmarineIndex: loadedSubmarineIndex, nameuser: loadedName, speedLevel: loadedSpeedLevel, howMuchIsTheFish: loadedHowMuchIsTheFishIndex)
        } else { return
        }
    }
    @IBAction func LoadSetting(_ sender: UIButton) {
        loadSetting()
    }
    
}
