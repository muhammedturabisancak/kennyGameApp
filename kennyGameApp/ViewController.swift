//
//  ViewController.swift
//  kennyGameApp
//
//  Created by Muhammed Turabi Sancak on 3.02.2024.
//

import UIKit

class ViewController: UIViewController {
  
  var score = 0
  var timer = Timer()
  var counter = 0
  var kennyArray = [UIImageView]()
  var hiddenTimer = Timer()
  var highScore = 0
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var highScoreLabel: UILabel!
  
  @IBOutlet weak var kennyN1: UIImageView!
  @IBOutlet weak var kennyN2: UIImageView!
  @IBOutlet weak var kennyT3: UIImageView!
  @IBOutlet weak var kennyT4: UIImageView!
  @IBOutlet weak var kennyA5: UIImageView!
  @IBOutlet weak var kennyN6: UIImageView!
  @IBOutlet weak var kennyN7: UIImageView!
  @IBOutlet weak var kennyT8: UIImageView!
  @IBOutlet weak var kennyN9: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scoreLabel.text = "Score: \(score)"
    
    //HighScore Check
    let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
    if storedHighScore == nil{
      highScore = 0
      highScoreLabel.text = "HighScore: \(highScore)"
    }
    if let newScore = storedHighScore as? Int{
      highScore = newScore
      highScoreLabel.text = "HighScore \(highScore)"
    }
    
    //Kenny Designer
    kennyN1.isUserInteractionEnabled = true
    kennyN2.isUserInteractionEnabled = true
    kennyT3.isUserInteractionEnabled = true
    kennyT4.isUserInteractionEnabled = true
    kennyA5.isUserInteractionEnabled = true
    kennyN6.isUserInteractionEnabled = true
    kennyN7.isUserInteractionEnabled = true
    kennyT8.isUserInteractionEnabled = true
    kennyN9.isUserInteractionEnabled = true
    let Recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyNormal))
    let Recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyNormal))
    let Recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyTaret))
    let Recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyTaret))
    let Recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyAwards))
    let Recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyNormal))
    let Recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyNormal))
    let Recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyTaret))
    let Recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScoreKennyNormal))
    kennyN1.addGestureRecognizer(Recognizer1)
    kennyN2.addGestureRecognizer(Recognizer2)
    kennyT3.addGestureRecognizer(Recognizer3)
    kennyT4.addGestureRecognizer(Recognizer4)
    kennyA5.addGestureRecognizer(Recognizer5)
    kennyN6.addGestureRecognizer(Recognizer6)
    kennyN7.addGestureRecognizer(Recognizer7)
    kennyT8.addGestureRecognizer(Recognizer8)
    kennyN9.addGestureRecognizer(Recognizer9)
    
    //Kenny Array
    kennyArray = [kennyN1,kennyN2,kennyT3,kennyT4,kennyA5,kennyN6,kennyN7,kennyT8,kennyN9]
    
    //Timer
    counter = 10
    timeLabel.text = String(counter)
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    
    //Tüm kennyleri saklama
    hideKenny()
  }
  
  //Kenny Saklama Fonksiyonu
  @objc func hideKenny(){
    for kenny in kennyArray{
      kenny.isHidden = true
    }
    let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
    kennyArray[random].isHidden = false }
  
  //Sayaç değiştirme fonksiyonları
  @objc func increaseScoreKennyNormal(){
    score += 1
    scoreLabel.text = "Score: \(score)"
  }
  @objc func increaseScoreKennyTaret(){
    score -= 1
    scoreLabel.text = "Score: \(score)"
  }
  @objc func increaseScoreKennyAwards(){
    score = score + 5
    scoreLabel.text = "Score: \(score)"
  }
  
  //Timer fonksiyonu
  @objc func timerFunction(){
    counter -= 1
    timeLabel.text = String(counter)
    
    if counter == 0 {
      timer.invalidate()
      hiddenTimer.invalidate()
      
      for kenny in kennyArray{
        kenny.isHidden = true
      }
      
      //High Score
      if self.score > self.highScore{
        self.highScore = self.score
        highScoreLabel.text = "High Score: \(self.highScore)"
        UserDefaults.standard.setValue(self.highScore, forKey: "highScore")
      }
      
      //Alert
      let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
      let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
      let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default)
      { UIAlertAction in
        //replay function
        self.score = 0
        self.scoreLabel.text = "Score: \(self.score)"
        self.counter = 10
        self.timeLabel.text = String(self.counter)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
        self.hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
      }
      alert.addAction(okButton)
      alert.addAction(replayButton)
      self.present(alert, animated: true, completion: nil)
      
    }
  }
}
      



