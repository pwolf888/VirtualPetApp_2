//
//  ViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 7/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var gravity : UIGravityBehavior?
    var animator : UIDynamicAnimator?

    var pooArray : [UIButton] = []
    
    @IBOutlet weak var MonsterSprite: UIImageView!
    
    // Declaration of timer variables
    var timerSeconds = 0
    let timerSecondsMax = 59
    var timer = Timer()
    var isTimerRunning = false
    
    

    @IBOutlet weak var monsterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // register an animator
        Utilities.loadDefaults()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [])
    
        let vector = CGVector(dx: 0.0, dy: 0.1)
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        
        
        dateChecker()
        
        
        runTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        hungerMeter.text  = "\(Utilities.hunger)"
        
        happinessMeter.text  = "\(Utilities.happiness)"
        
        if Utilities.xp >= 100 {
           // Utilities.level = Utilities.xp / 100
        }
        
        ageLabel.text = "\(Utilities.age) yrs"
        levelLabel.text  = "LVL \(Utilities.level)"
        
        
      
        evolutionCheck()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    // A simple timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        
        
    }
    
    func updateTimer() {
        if isTimerRunning == true {
            if timerSeconds == 59 {
                timerSeconds = 0
                timerLabel.text = "\(timerSeconds)"
            } else {
                timerSeconds += 1
                timerLabel.text = "\(timerSeconds)"
            }
        
        
            if timerSeconds % 10 < 1 {
                unhappyHungry()
            }
            if timerSeconds % 30 < 1 {
                addPoo(Any.self)
            }
        }
    }
   
    
    
    // A function to reduce the happiness and hunger variables
    func unhappyHungry() {
        
        Utilities.hunger -= 1
        
        hungerMeter.text = "\(Utilities.hunger)"
        
        if Utilities.hunger < 50 {
            Utilities.happiness -= 1
            happinessMeter.text = "\(Utilities.happiness)"
            
        }
        
        if Utilities.happiness <= 0 && Utilities.hunger <= 0 {
            MonsterObject.setImage(Utilities.monsterImages[3], for: .normal)
            isTimerRunning = false
        }
        
    }
    
    // A function to find the difference between the last date accessed and the new date.
    func dateChecker() {
        
        var ageCheck = -Utilities.birthDate.timeIntervalSinceNow
        ageCheck = ageCheck / 60
        ageCheck.round()
        Utilities.age = Int(ageCheck)
        
        var timeDifference = -Utilities.lastOpen.timeIntervalSinceNow

        if timeDifference > 200 {
            // Reduce the number to a lower value.
            timeDifference = timeDifference / 30
            timeDifference.round()
            
            print(timeDifference)
            
            for _ in 0..<Int(timeDifference) {
                unhappyHungry()
                addPoo(Any.self)
            }
            
        }
        
    }
    
    
    
    // IBOutlets for UI labels - 8 Happiness etc
    @IBOutlet weak var happinessMeter: UILabel!
    @IBOutlet weak var hungerMeter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    
    // Button action to pat the creature
    @IBAction func patBtn(_ sender: UIButton) {
        if Utilities.happiness < 100 {
            let love = UIButton(frame: CGRect(x: 200, y: 60, width: 50, height: 50))
            love.setImage(UIImage(named: "heart"), for: .normal)
            
            self.view.addSubview(love)
            gravity?.addItem((love as UIView))
            
            Utilities.happiness += 1
            happinessMeter.text = "\(Utilities.happiness)"
            
        }
        
    }
    
    // Button action to feed the creature
    @IBAction func feedBtn(_ sender: UIButton) {
        if Utilities.hunger < 100 {
            let food = UIButton(frame: CGRect(x: 100, y: 60, width: 50, height: 50))
            food.setImage(UIImage(named: "feed"), for: .normal)

            self.view.addSubview(food)
            gravity?.addItem((food as UIView))
        
            Utilities.hunger += 1
            hungerMeter.text = "\(Utilities.hunger)"
            
        }
        
    }
    
    
    // a light switch for when the monster wants to sleep
    @IBAction func lightBtn(_ sender: UIButton) {
    }
    
    
    func addPoo (_ : Any) {
        let xCoordinate = arc4random() % UInt32(self.view.bounds.width)
        
        let poo = UIButton(frame: CGRect(x: Int(xCoordinate), y: 300, width: 50, height: 50))
        poo.setImage(UIImage(named: "poo"), for: .normal)
        poo.addTarget(self, action: #selector(self.didCleanPoo(sender:)), for: .touchUpInside)
        self.view.addSubview(poo)
        pooArray.append(poo)
        Utilities.poo += 1
        print(Utilities.poo)
        
        
    }
    
    @IBAction func cleanAllPoo(_ sender: UIButton) {
        for poo in pooArray {
            poo.removeFromSuperview()
        }
        Utilities.poo = 0
    }
    func didCleanPoo(sender: UIButton) {
        sender.setImage(UIImage(named : "pop"), for: .normal)
        UIView.animate(withDuration: 0.4,
                       animations: {sender.alpha = 0},
                       completion: { (true) in sender.removeFromSuperview()} )
        Utilities.poo -= 1
    }
    
    
    @IBAction func Monster(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var MonsterObject: UIButton!
    // Checks the level of the monster and what stage it should be
    func evolutionCheck() {
        
        switch (Utilities.level) {
            
        case 0...4:
            if Utilities.redTrue == true {
                MonsterObject.setImage(Utilities.splitEvoImages[5], for: .normal)
            }
            else if Utilities.greenTrue == true  {
                MonsterObject.setImage(Utilities.splitEvoImages[4], for: .normal)
                
            }
        case 5...9:
            MonsterObject.setImage(Utilities.monsterImages[0], for: .normal)
            
        case 10...19:
            if Utilities.redTrue == true {
                MonsterObject.setImage(Utilities.splitEvoImages[0], for: .normal)
                
            }
            else if Utilities.greenTrue == true  {
                MonsterObject.setImage(Utilities.splitEvoImages[2], for: .normal)
                
            }
            else {
                MonsterObject.setImage(Utilities.monsterImages[1], for: .normal)
                
            }
            
        case 20...100:
            
            if Utilities.redTrue == true {
                MonsterObject.setImage(Utilities.splitEvoImages[1], for: .normal)
            }
            else if Utilities.greenTrue == true  {
                MonsterObject.setImage(Utilities.splitEvoImages[3], for: .normal)
                
            }
            else  {
                MonsterObject.setImage(Utilities.monsterImages[2], for: .normal)
                
            }
            
        default:
            MonsterObject.setImage(UIImage(named: "egg"), for: .normal)
        }

    }
    
    // Make a new monster
    @IBAction func STARTBtn(_ sender: UIButton) {
        isTimerRunning = true
        Utilities.resetDefaults()
        hungerMeter.text  = "\(Utilities.hunger)"
        happinessMeter.text  = "\(Utilities.happiness)"
        ageLabel.text = "\(Utilities.age) Yrs"
        levelLabel.text = "Lvl \(Utilities.level)"
        
        for poo in pooArray {
            poo.removeFromSuperview()
        }
        let colorMonster = arc4random() % UInt32(3)
        
        switch (colorMonster) {
        case 1:
            Utilities.greenTrue = true
        
        case 2:
            Utilities.redTrue = true
        
        default:
            Utilities.blueTrue = true
            
        }
        evolutionCheck()
        pooArray = []
    }
}

