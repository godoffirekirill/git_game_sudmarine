//
//  ViewController.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 04.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var sudmarineView: UIImageView!
    @IBOutlet weak var wavesView: UIImageView!
    @IBOutlet weak var bottomView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var PanelView: UIView!
    @IBOutlet weak var wavesTwoView: UIImageView!
    @IBOutlet weak var UpButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var oxegenView: UIView!
    
    @IBOutlet weak var oxygenViewHightConstrain: NSLayoutConstraint!
    var timer: Timer?
    var fishTimer: Timer?
    var fishTimerOne: Timer?
    var oxygenTimer: Timer?
    var shipTimer: Timer?
    var stopGameTime: Timer?
    
    
    var fishViewTimer: Timer?
    var timersArray: [Timer] = []
    var fishViews: [UIView] = []
    var shipViews: [UIView] = []
    var arrayFish = Manager.shared.fishImages
    var arrayFishIndex = 0
    var arraySubmarine = Manager.shared.submarineImage
    var arraySubmarineIndex = 0
    var speedAnimated: CGFloat?
    var speedLevels = Manager.shared.speedLevels
    var speedAnimatedKey: String?
    var howMuchisTheFish = Manager.shared.howMuchIsTheFishNumber
    var howMuchisTheFishIndex = 0
    var howMuchisTheFishSelected: Int?
    var isGameRunning = false
    var userName: String?
    var scoreCount: Int = 0
    var timerScore: Timer?
    
    
    let sudmarineExplotion = UIImage(named: "submarineExplosion")
    let sudmarine = UIImage(named: "submarineGame")
    let wavesTwo = UIImage(named: "waterSubmarine")
    let waves = UIImage(named: "waterSubmarine")
    let bottom = UIImage(named: "seaBottom")
    let ship = UIImage(named: "seaShip")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PanelView.layer.zPosition = 1
        sudmarineView.layer.zPosition = 2
      //  self.sudmarineView.image = sudmarine
        self.view.bringSubviewToFront(sudmarineView)
        
        self.wavesTwoView.image = wavesTwo
        self.wavesView.image = waves
        // self.bottomView.image = bottom
        
        // backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "waterBubbles")!)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.wavesView.transform = CGAffineTransform(translationX: 0, y: 10)
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.wavesTwoView.transform = CGAffineTransform(translationX: 0, y: 10)
        }, completion: nil)
        
        
        startBackgroundScroll()
        startBackgroundScrollBottom()
        
        
        
        loadSetting()

        startGame()
    }
    
    @IBAction func upBottonpressedDown(_ sender: UIButton) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            UIView.animate(withDuration: 0.3) {
                if self.sudmarineView.frame.origin.y > 40 {
                    self.sudmarineView.frame.origin.y -= 10
                }
            }
        })
    }
    
    @IBAction func upBottonPressed(_ sender: UIButton) {
        timer?.invalidate()
    }
    
    @IBAction func downButtonPressed(_ sender: UIButton) {
        timer?.invalidate()
    }
    @IBAction func downButtonPressedDown(_ sender: UIButton) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            UIView.animate(withDuration: 0.3) {
                let screenHeight = UIScreen.main.bounds.height
                let objectMaxY = self.sudmarineView.frame.origin.y + self.sudmarineView.frame.size.height
                
                if objectMaxY < screenHeight - 70 {
                    self.sudmarineView.frame.origin.y += 10
                    
                } else if self.sudmarineView.frame.intersects(self.bottomView.frame) {
                    self.stopGame()
                }
            }
        })
        
    }
    
    func randomFishYPosition() -> CGFloat {
        let minY: CGFloat = 40.0
        let maxY: CGFloat = self.view.frame.height - 120.0
        return CGFloat.random(in: minY...maxY)
    }
    
    func randomDelay() -> Double {
        let minT: Double = 1
        let maxT: Double = 3
        return Double.random(in: minT...maxT)
    }
    
    func getRandomFishImage() -> String? {
        guard !arrayFish.isEmpty else {
            return nil // Return nil if the array is empty
        }
        
         arrayFishIndex = Int.random(in: 0..<arrayFish.count)
        return arrayFish[arrayFishIndex]
    }
    
    
    func addOxygen() {
        
        let maxOxygenHeight: CGFloat = 310
        let oxygenDepletionRate: CGFloat = 10
        
        self.oxygenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            UIView.animate(withDuration: 0.3) {
                if self.oxygenViewHightConstrain.constant <= 0 {
                    self.stopGame()
                }
                self.oxygenViewHightConstrain.constant -= oxygenDepletionRate
                self.view.layoutIfNeeded()
                if self.sudmarineView.frame.intersects(self.wavesView.frame) {
                    if self.oxygenViewHightConstrain.constant < maxOxygenHeight {
                        self.oxygenViewHightConstrain.constant += oxygenDepletionRate * 2
                        self.view.layoutIfNeeded()
                        
                    }
                    
                    // Call this method to update constraints
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    
    func createShip() {
        let initialX = self.view.frame.width
        let initialY = 0
        let wightShip: CGFloat = 500
        let heighShip: CGFloat = 80
        let delay = self.randomDelay()
        let shipView = UIImageView(frame: CGRect(x: initialX, y: CGFloat(initialY), width: wightShip, height: heighShip))
        shipView.image = UIImage(named: "shipTwo")
        
        self.view.addSubview(shipView)
        shipViews.append(shipView)
        
        shipTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            UIView.animate(withDuration: 0.03,delay: delay) {
                shipView.frame.origin.x -= 1
                
                if shipView.frame.intersects(self.sudmarineView.frame) {
                    self.shipTimer?.invalidate()
                    self.stopGame()
                } else {
                    if shipView.frame.maxX < 0 {
                        self.shipTimer?.invalidate()
                        shipView.removeFromSuperview()
                        if self.isGameRunning {
                            self.createShip()
                        }
                    }
                }
            }
        }
                                         
        )
    }
    func Score() {
        timerScore = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] _ in
            
            
            self.scoreCount += 1
            scoreLabel.text = "\(String(describing: scoreCount))"
            self.view.layoutIfNeeded()
        })
    }
    
    private func createFishView(imageName: String) -> UIImageView {
        let initialX = self.view.frame.width
        let initialY = randomFishYPosition()
        let width: CGFloat = 120
        let height: CGFloat = 80

        let fishView = UIImageView(frame: CGRect(x: initialX, y: initialY, width: width, height: height))
        fishView.image = UIImage(named: imageName)
        self.view.addSubview(fishView)
        fishViews.append(fishView)

        return fishView
    }

    private let animationDuration: TimeInterval = 0.3
    func speedFish() -> CGFloat {
        guard let speedAnimated = self.speedAnimated else { return 0.0 }
        return speedAnimated
    }

    var speed: CGFloat {
        return speedFish()
    }


    private func animateFishView(_ fishView: UIImageView, delay: Double) {
        
        
        var fishTimer = Timer()
         fishTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self, weak fishView] _ in
            guard let strongSelf = self, let strongFishView = fishView else {
                return
            }

            UIView.animate(withDuration: strongSelf.animationDuration, delay: delay) {
                strongFishView.frame.origin.x -= self!.speed

                if strongFishView.frame.intersects(strongSelf.sudmarineView.frame) {
                    fishTimer.invalidate()
                    strongSelf.stopGame()
                } else {
                    if strongFishView.frame.maxX < 0 {
                        fishTimer.invalidate()
                        strongFishView.removeFromSuperview()
                        if strongSelf.isGameRunning {
                            strongSelf.createFish(count: 1)
                        }
                    }
                }
            }
        }
    }

    func createFish(count: Int) {
        guard count > 0 else { return }

        for _ in 1...count {
            let fishView = createFishView(imageName: getRandomFishImage() ?? "defaultFishImage")
            let delay = randomDelay()
            animateFishView(fishView, delay: delay)
        }
    }




    
    
    
    func createFishTwo() {
        
       
            let initialX = self.view.frame.width
            let initialY = randomFishYPosition()
            let delay = self.randomDelay()
            let wightFish: CGFloat = 120
            let heightfish: CGFloat = 80

            let fishView = UIImageView(frame: CGRect(x: initialX, y: initialY, width: wightFish, height: heightfish))
            
            if let randomFishImage = getRandomFishImage() {
                fishView.image = UIImage(named: randomFishImage)
            }
            
            self.view.addSubview(fishView)
            fishViews.append(fishView)

            fishTimerOne = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
                UIView.animate(withDuration: 0.03, delay: delay) {
                    fishView.frame.origin.x -= 1
                    
                    if fishView.frame.intersects(self.sudmarineView.frame) {
                        self.fishTimerOne?.invalidate()
                        self.stopGame()
                    } else {
                        if fishView.frame.maxX < 0 {
                            self.fishTimerOne?.invalidate()
                            fishView.removeFromSuperview()
                            if self.isGameRunning {
                                self.createFishOne()
                            }
                        }
                    }
                }
            })
        }




    func createFishOne() {
        
        
        let initialX = self.view.frame.width
        let initialY = randomFishYPosition()
        let delay = self.randomDelay()
        let wightFish: CGFloat = 120
        let heightfish: CGFloat = 80
        
        let fishView = UIImageView(frame: CGRect(x: initialX, y: initialY, width: wightFish, height: heightfish))
        fishView.image = UIImage(named: "fishOneFinal")
        
        self.view.addSubview(fishView)
        fishViews.append(fishView)
        
        fishTimerOne = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            UIView.animate(withDuration: 0.03, delay: delay) {
                fishView.frame.origin.x -= 1
                
                if fishView.frame.intersects(self.sudmarineView.frame) {
                    self.fishTimerOne?.invalidate()
                    self.stopGame()
                } else {
                    if fishView.frame.maxX < 0 {
                        self.fishTimerOne?.invalidate()
                        fishView.removeFromSuperview()
                        if self.isGameRunning {
                            self.createFishOne()
                        }
                    }
                }
            }
        }
                                            
        )
        
    }
    
    func startBackgroundScroll() {
        let backgroundImageView = UIImageView(image: UIImage(named: "waterBubblesTwo"))
        
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width * 2, height: view.frame.size.height)
        backgroundImageView.layer.zPosition = -2
        view.addSubview(backgroundImageView)
        
        UIView.animate(withDuration: 10.0, delay: 0.0, options: [.curveLinear, .repeat], animations: {
            backgroundImageView.frame.origin.x -= self.view.frame.width
        }, completion: nil)
    }
    
    func startBackgroundScrollBottom() {
        let backgroundImageView = UIImageView(image: UIImage(named: "seaBottom"))
        
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        // Set the initial frame of the background image
        backgroundImageView.frame = CGRect(x: 0, y: viewHeight - 70, width: viewWidth * 2, height: 70)
        backgroundImageView.layer.zPosition = -1
        view.addSubview(backgroundImageView)
        
        // Animate the background image to scroll horizontally
        UIView.animate(withDuration: 10.0, delay: 0.0, options: [.curveLinear, .repeat], animations: {
            backgroundImageView.frame.origin.x -= viewWidth
        }, completion: nil)
    }
    
    
    
    
    func startGame() {
        isGameRunning = true
        
        //createFish()
      //  createFishTwo()
       // createFishOne()
        
        createFish(count: howMuchisTheFishSelected ?? 0)
        
        createShip()
        addOxygen()
        Score()
    }
    
/*  func recordDate() {
        
        let gameStartTime = GameResult(startTime: Date())
        UserDefaults.standard.set(encodable: gameStartTime, forKey: "gameStartTime")
    }*/
    
    func stopGame() {
        isGameRunning = false
        safeRecords()
        self.timerScore?.invalidate()
        self.fishTimer?.invalidate()
        self.oxygenTimer?.invalidate()
        self.shipTimer?.invalidate()
        //oxygenTimer?.invalidate()
        //fishTimer?.invalidate()
        self.sudmarineView.image = sudmarineExplotion
        self.timer?.invalidate()
      //  self.navigationController?.popViewController(animated: true)

       // self.timer?.invalidate()
        stopGameTime = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
            UIView.animate(withDuration: 0.3) {
                let screenHeight = UIScreen.main.bounds.height
                let objectMaxY = self.sudmarineView.frame.origin.y + self.sudmarineView.frame.size.height
                
                if objectMaxY < screenHeight - 20{
                    self.sudmarineView.frame.origin.y += 10
                    self.stopGameTime = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
                        self.stopGameTime?.invalidate()
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    
                }
            }
        })
        
    }
    func safeRecords() {
        let date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: date)
        let score = scoreCount
        guard let difficulty = speedAnimatedKey, let name = userName  else {
            // Print statements or breakpoints to check values
            print("Difficulty, UserName, or Score is nil.")
            return
        }

        let recordData = ["Date": formattedDate, "UserName": name, "difficulty": difficulty, "Score": score] as [String: Any]
        
        var existingGames = UserDefaults.standard.array(forKey: "Games") as? [[String: Any]] ?? []
        Manager.shared.safeRecords.append(recordData)
        UserDefaults.standard.set(existingGames, forKey: "Games")

        
        print(recordData)
    }

    
    func loadSetting() {
        //   loadedSettings = Magager.shared.UserDefaults.standard.value(Setting.self, forKey: "settingConfig")
        if let loadedSettings = Manager.shared.loadSetting() {
            let loadedName = loadedSettings.nameuser
            
            let loadedSubmarineIndex = loadedSettings.currentSubmarineIndex
            let loadedSelectedSpeedKey = loadedSettings.selectedSpeedKey
            let loadedHowMuchIsTheFishIndex = loadedSettings.howMuchIsTheFish
            print(loadedSubmarineIndex)
            print(loadedSelectedSpeedKey)
            print(loadedHowMuchIsTheFishIndex)
            
            arraySubmarineIndex = loadedSubmarineIndex
            howMuchisTheFishIndex = loadedHowMuchIsTheFishIndex
            speedAnimatedKey = loadedSelectedSpeedKey
            print("\(speedAnimatedKey)")
            userName = loadedName
          //  let sudmarine = UIImage(named: "submarineGame")
            self.sudmarineView.image = UIImage(named: arraySubmarine[loadedSubmarineIndex])
            howMuchisTheFishSelected = Int(howMuchisTheFish[loadedHowMuchIsTheFishIndex])
          //  print(speedLevels.index(forKey: speedAnimatedKey))
            speedAnimated = speedLevels[speedAnimatedKey ?? "Low"]
           // print("\(howMuchisTheFishSelected)")
        }
        
    }
    
    
}





/*
func createFishOne() {
    let numberOfFish = 5 // Set the number of fish you want to create

    for _ in 0..<numberOfFish {
        let initialX = self.view.frame.width
        let initialY = randomFishYPosition()
        let delay = self.randomDelay()
        let wightFish: CGFloat = 120
        let heightfish: CGFloat = 80

        let fishView = UIImageView(frame: CGRect(x: initialX, y: initialY, width: wightFish, height: heightfish))
        
        if let randomFishImage = getRandomFishImage() {
            fishView.image = UIImage(named: randomFishImage)
        }
        
        self.view.addSubview(fishView)
        fishViews.append(fishView)

        fishTimerOne = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            UIView.animate(withDuration: 0.03, delay: delay) {
                fishView.frame.origin.x -= 1
                
                if fishView.frame.intersects(self.sudmarineView.frame) {
                    self.fishTimerOne?.invalidate()
                    self.stopGame()
                } else {
                    if fishView.frame.maxX < 0 {
                        self.fishTimerOne?.invalidate()
                        fishView.removeFromSuperview()
                        if self.isGameRunning {
                            self.createFishOne()
                        }
                    }
                }
            }
        })
    }
}

// Update getRandomFishImage to use arrayFish without an index
func getRandomFishImage() -> String? {
    guard !arrayFish.isEmpty else {
        return nil // Return nil if the array is empty
    }

    let randomIndex = Int.random(in: 0..<arrayFish.count)
    return arrayFish[randomIndex]
}
*/
