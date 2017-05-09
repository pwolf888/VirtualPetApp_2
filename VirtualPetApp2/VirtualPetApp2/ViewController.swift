//
//  ViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 7/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MonsterSprite: UIImageView!
    // Can be used to alter te sprite on the scene
    //MonsterSprite.image = UIImage(named: "baby")
    
    // Declares the userdefaults standard method for setting and getting
    let defaults = UserDefaults.standard
    
    var timerSeconds = 0
    let timerSecondsMax = 59
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    
    
    var newCreature = Monster(happiness: 8, hunger: 8)
    
    let tenMinutesFromNow =  10
    let twentyMinutesFromNow =  20
    let thirtyMinutesFromNow =  30
    let fortyMinutesFromNow =  40
    let fiftyMinutesFromNow =  50
    let sixtyMinutesFromNow = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        runTimer()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
        
        if timerSeconds % 10 <= 1 {
            timeCheck()
        }
        
    }
    
    func timeCheck() {
        
        switch timerSeconds {
            
        case tenMinutesFromNow:
            unhappyHungry()
            print("I have pooed once")
            
        case twentyMinutesFromNow:
            unhappyHungry()
            print("I have pooed twice")
            
        case thirtyMinutesFromNow:
            unhappyHungry()
            print("I have pooed thrice")
            
        case fortyMinutesFromNow:
            unhappyHungry()
            print("I have pooed four times")
            
        case fiftyMinutesFromNow:
            unhappyHungry()
            
            print("I have pooed 5 times")
            
        default:
            
            print("I am thinking about pooing soon")
            
            
            
        }
        
    }
    
    // A function to reduce the happiness and hunger variables
    func unhappyHungry() {
        newCreature.happiness -= 1
        newCreature.hunger -= 1
        happinessMeter.text = "\(newCreature.happiness)"
        hungerMeter.text = "\(newCreature.hunger)"
    }
    
    
    // IBOutlets for UI labels - 8 Happiness etc
    @IBOutlet weak var happinessMeter: UILabel!
    @IBOutlet weak var hungerMeter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    // Button action to pat the creature
    @IBAction func patBtn(_ sender: UIButton) {
        if newCreature.hunger < 8 {
            newCreature.happiness += 1
            happinessMeter.text = "\(newCreature.happiness)"
            
            
        }
    }
    
    // Button action to feed the creature
    @IBAction func feedBtn(_ sender: UIButton) {
        if newCreature.hunger < 8 {
            newCreature.hunger += 1
            hungerMeter.text = "\(newCreature.hunger)"
        }
    }

    }

