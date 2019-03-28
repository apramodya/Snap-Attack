//
//  ViewController.swift
//  Snap Attack
//
//  Created by Pramodya Abeysinghe on 28/3/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var firstCard: UIImageView!
    @IBOutlet weak var secondCard: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    
    var timer = Timer()
    var cardTimer = Timer()
    var timerInt = Constants.MAX_TIME
    var scoreInt = 0
    var gameMode = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        timeLbl.text = String("Time: \(Constants.MAX_TIME)")
    }

    @IBAction func startGame(_ sender: Any) {
        if timerInt == Constants.MAX_TIME {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            cardTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCards), userInfo: nil, repeats: true)
            startBtn.isEnabled = false
            startBtn.alpha = 0.25
            startBtn.setTitle("Snap", for: .normal)
        }
        
        if gameMode == 1 {
            if firstCard.image == secondCard.image {
                scoreInt += 1
                scoreLbl.text = String("Score: \(scoreInt)")
            } else {
                scoreInt -= 1
                scoreLbl.text = String("Score: \(self.scoreInt)")
            }
        }
        
        if timerInt == 0 {
            timerInt = Constants.MAX_TIME
            scoreInt = 0
            
            timeLbl.text = String("Time: \(timerInt)")
            scoreLbl.text = String("Score: \(self.scoreInt)")
            
            startBtn.setTitle("Start", for: .normal)
            
            firstCard.image = UIImage(named: "blue_cover")
            secondCard.image = UIImage(named: "blue_cover")
        }
    }
    
    @objc func updateTimer() {
        timerInt -= 1
        gameMode = 1
        
        timeLbl.text = String("Time: \(timerInt)")
        startBtn.isEnabled = true
        startBtn.alpha = 1
        
        if timerInt == 0 {
            timer.invalidate()
            cardTimer.invalidate()
            
            gameMode = 0
            startBtn.setTitle("Restart", for: .normal)
        }
    }
    
    @objc func updateCards() {
        let cards = Constants.CARD_LIST
        
        firstCard.image = UIImage(named: cards.randomElement()!)
        secondCard.image = UIImage(named: cards.randomElement()!)
    }
    
}

