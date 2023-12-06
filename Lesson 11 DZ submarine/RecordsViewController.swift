//
//  RecordsViewController.swift
//  Lesson 11 DZ submarine
//
//  Created by Кирилл Курочкин on 04.10.2023.
//

import UIKit

class RecordsViewController: UIViewController {

    @IBOutlet weak var recordsTable: UITableView!
    
    
    
    var arrayProperties = ["Date","User Name ", "Difficulty", "Score"]
    var array = Manager.shared.safeRecords
    var arrayProperties1 = ["Date","User Name ", "Difficulty", "Score"]

    override func viewDidLoad() {
        super.viewDidLoad()
       print(array)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)

        backgroundImage.image = UIImage(named: "StartLogo")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    

}
extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Manager.shared.safeRecords.count // сколько ячеек в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsTableViewCell", for: indexPath) as? RecordsTableViewCell else {
            return UITableViewCell()
        }

        let gameData = Manager.shared.safeRecords[indexPath.row]
        cell.configure(with: gameData)

        return cell
    }

}

    /*        if indexPath.row == 0 {
     // First cell
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsTableViewCell", for: indexPath) as? RecordsTableViewCell else {
     return UITableViewCell()
     }
     cell.configure(with: arrayProperties)
     return cell
     } else {
     // Second cell
     guard let secondCell = tableView.dequeueReusableCell(withIdentifier: "RecordSecondTableViewCell", for: indexPath) as? RecordSecondTableViewCell else {
     return UITableViewCell()
     }
     let game = array[indexPath.row]
     
     if let date = game["Date"] as? Date {
     secondCell.firstLabel.text = "\(date)"// Format date as a string
     }
     
     if let userName = game["UserName"] as? String {
     secondCell.secondLabel.text = userName
     }
     
     if let difficulty = game["Difficulty"] as? String {
     secondCell.thirdLabel.text = difficulty
     }
     
     if let score = game["Score"] as? Int {
     secondCell.fourLabel.text = "\(score)"
     }
     print("\(Manager.shared.safeRecords)")
     return secondCell
     }*/
    

