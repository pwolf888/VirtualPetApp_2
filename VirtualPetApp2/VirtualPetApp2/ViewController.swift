//
//  ViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 7/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // Adds gravity
    var gravity : UIGravityBehavior?
    var animator : UIDynamicAnimator?

    @IBOutlet weak var MonsterSprite: UIImageView!
    
    // Declaration of timer variables
    var timerSeconds = 0
    let timerSecondsMax = 59
    var timer = Timer()
    var isTimerRunning = false
    var pooArray : [UIButton] = []

    @IBOutlet weak var monsterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the user defaults when the view loads
        Utilities.loadDefaults()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [])
    
        let vector = CGVector(dx: 0.0, dy: 0.1)
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        
        // Checks the date to add things to the stage
        dateChecker()
        // Starts the timer
        runTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        hungerMeter.text  = "\(Utilities.hunger)"
        
        happinessMeter.text  = "\(Utilities.happiness)"
        
        if Utilities.xp >= 100 {
           Utilities.level = Utilities.xp / 100
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
    
    // Updates the timer function and adds poo to the stage and lowers hunger and happiness
    func updateTimer() {
        if isTimerRunning == true {
            if timerSeconds == 59 {
                timerSeconds = 0
                
            } else {
                timerSeconds += 1
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
        
        // Removes points from the creature and adds poos to the stage
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
    
    
    // IBOutlets for UI labels
    @IBOutlet weak var happinessMeter: UILabel!
    @IBOutlet weak var hungerMeter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    
    // Button action to pat the creature - love hearts will animate down the screen
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
    
    // Button action to feed the creature - food will animate down the screen
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
    
    // Function to randomly add the poo to the stage.
    func addPoo (_ : Any) {
        let xCoordinate = arc4random() % UInt32(self.view.bounds.width)
        
        let poo = UIButton(frame: CGRect(x: Int(xCoordinate), y: 300, width: 50, height: 50))
        poo.setImage(UIImage(named: "poo"), for: .normal)
        poo.addTarget(self, action: #selector(self.didCleanPoo(sender:)), for: .touchUpInside)
        self.view.addSubview(poo)
        pooArray.append(poo)
        Utilities.poo += 1
       
    }
    // A btn to clear all mess fromt he stage
    @IBAction func cleanAllPoo(_ sender: UIButton) {
        for poo in pooArray {
            poo.removeFromSuperview()
        }
        Utilities.poo = 0
    }
    
    // Animation to remove the poo buttons
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
        
        // Checks if the colorTrue variables, and choose the right image to display.
        switch (Utilities.level) {
            
        case 0...4:
            if Utilities.redTrue == true {
                MonsterObject.setImage(Utilities.splitEvoImages[5], for: .normal)
            }
            else if Utilities.greenTrue == true  {
                MonsterObject.setImage(Utilities.splitEvoImages[4], for: .normal)
                
            }
            else if Utilities.blueTrue == true  {
                MonsterObject.setImage(UIImage(named: "egg"), for: .normal)
                
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
            else if Utilities.blueTrue == true {
                MonsterObject.setImage(Utilities.monsterImages[1], for: .normal)
                
            }
            
        case 20...100:
            
            if Utilities.redTrue == true {
                MonsterObject.setImage(Utilities.splitEvoImages[1], for: .normal)
            }
            else if Utilities.greenTrue == true  {
                MonsterObject.setImage(Utilities.splitEvoImages[3], for: .normal)
                
            }
            else if Utilities.blueTrue == true  {
                MonsterObject.setImage(Utilities.monsterImages[2], for: .normal)
                
            }
            
        default:
            MonsterObject.setImage(UIImage(named: "poo"), for: .normal)
        }
        
    }
    
    // Make a new monster
    @IBAction func STARTBtn(_ sender: UIButton) {
        // Reset the label values
        isTimerRunning = true
        Utilities.resetDefaults()
        hungerMeter.text  = "\(Utilities.hunger)"
        happinessMeter.text  = "\(Utilities.happiness)"
        ageLabel.text = "\(Utilities.age) Yrs"
        levelLabel.text = "Lvl \(Utilities.level)"
        
        // Clear the mess
        for poo in pooArray {
            poo.removeFromSuperview()
        }
        let colorMonster = arc4random() % UInt32(3)
        
        // Choose a random evolustion  line.
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

