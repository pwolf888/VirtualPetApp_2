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
    var hunger: Int = 0
    var happiness: Int = 0
    
    
    let monsterImage = [UIImage(named: "baby"),
                        UIImage(named: "toddler"),
                        UIImage(named: "teen")]
    
    @IBOutlet weak var MonsterSprite: UIImageView!
    // Can be used to alter te sprite on the scene
    //MonsterSprite.image = UIImage(named: "baby")
    
    // Declares the userdefaults standard method for setting and getting
    let defaults = UserDefaults.standard
    
    
    // Declaration of timer variables
    var timerSeconds = 0
    let timerSecondsMax = 59
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    

    @IBOutlet weak var monsterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // register an animator
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [])
    
        let vector = CGVector(dx: 0.0, dy: 0.1)
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        
        runTimer()
        let lastOpen = Date()
        defaults.set(lastOpen, forKey:"LastOpen")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let x = defaults.integer(forKey: "Hunger")
            hunger = x
            hungerMeter.text  = "\(x)"
        
        let y = defaults.integer(forKey: "Happiness")
            happiness = y
            happinessMeter.text  = "\(y)"
        
        dateChecker()
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
        if timerSeconds == 59 {
            timerSeconds = 0
            timerLabel.text = "\(timerSeconds)"
        } else {
            timerSeconds += 1
            timerLabel.text = "\(timerSeconds)"
        }
        
        if timerSeconds % 10 < 1 {
            unhappyHungry()
            addPoo(Any.self)
        }
        
    }
   
    
    // A function to reduce the happiness and hunger variables
    func unhappyHungry() {
        
        hunger -= 1
        defaults.set(hunger, forKey: "Hunger")
        hungerMeter.text = "\(hunger)"
        
        if hunger < 50 {
            happiness -= 1
            defaults.set(happiness, forKey: "Happiness")
            happinessMeter.text = "\(happiness)"
        }
        defaults.synchronize()
    }
    
    // A function to find the difference between the last date accessed and the new date.
    func dateChecker() {
        let newDate = Date()
        let lastOpen = defaults.object(forKey: "LastOpen") as? Date ?? Date.distantFuture
        
        
        var timeDifference = lastOpen.timeIntervalSinceReferenceDate
        timeDifference = timeDifference / 60
        //timeDifference.round()
        print(timeDifference)
    }
    
    
    
    // IBOutlets for UI labels - 8 Happiness etc
    @IBOutlet weak var happinessMeter: UILabel!
    @IBOutlet weak var hungerMeter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    // Button action to pat the creature
    @IBAction func patBtn(_ sender: UIButton) {
        if hunger < 100 {
            
            happiness += 1
            happinessMeter.text = "\(happiness)"
            defaults.set(happiness, forKey: "Happiness")
        }
        defaults.synchronize()
    }
    
    // Button action to feed the creature
    @IBAction func feedBtn(_ sender: UIButton) {
        if hunger < 100 {
            let food = UIButton(frame: CGRect(x: 100, y: 60, width: 50, height: 50))
            food.setImage(UIImage(named: "feed"), for: .normal)

            self.view.addSubview(food)
            gravity?.addItem((food as UIView))
        
            hunger += 1
            hungerMeter.text = "\(hunger)"
            defaults.set(hunger, forKey: "Hunger")
        }
        defaults.synchronize()
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
        
    }
    
    func didCleanPoo(sender: UIButton) {
        sender.setImage(UIImage(named : "pop"), for: .normal)
        UIView.animate(withDuration: 0.4,
                       animations: {sender.alpha = 0},
                       completion: { (true) in sender.removeFromSuperview()} )
    }
}

