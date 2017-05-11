//
//  ViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 7/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    var newCreature = Monster(age: 0, happiness: 50, hunger: 50)

    @IBOutlet weak var monsterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        runTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let x = defaults.object(forKey: "Hunger") as? Int {
            hungerMeter.text  = "\(x)"
        }
        if let y = defaults.object(forKey: "Happiness") as? Int {
            hungerMeter.text  = "\(y)"
        }
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
        }
        
    }
   
    
    // A function to reduce the happiness and hunger variables
    func unhappyHungry() {
        
        newCreature.hunger -= 1
        //happinessMeter.text = "\(newCreature.happiness)"
        //hungerMeter.text = "\(newCreature.hunger)"
        
        if newCreature.hunger < 50 {
            newCreature.happiness -= 1
        }
        
    }
    
    // A function to find the difference between the last date accessed and the new date.
    
    
    
    // IBOutlets for UI labels - 8 Happiness etc
    @IBOutlet weak var happinessMeter: UILabel!
    @IBOutlet weak var hungerMeter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    // Button action to pat the creature
    @IBAction func patBtn(_ sender: UIButton) {
        if newCreature.hunger < 100 {
            newCreature.happiness += 1
            happinessMeter.text = "\(newCreature.happiness)"
            defaults.set("\(happinessMeter)", forKey: "Happiness")
        }
    }
    
    // Button action to feed the creature
    @IBAction func feedBtn(_ sender: UIButton) {
        if newCreature.hunger < 100 {
            newCreature.hunger += 1
            hungerMeter.text = "\(newCreature.hunger)"
            defaults.set("\(hungerMeter)", forKey: "Hunger")
        }
    }
    
    // Jump to the training mini game in the - TrainViewController
    @IBAction func trainBtn(_ sender: UIButton) {
       // Move to second view
    }
    
    // a light switch for when the monster wants to sleep
    @IBAction func lightBtn(_ sender: UIButton) {
    }
    
    // A button used to clean the monsters mess
    @IBAction func cleanBtn(_ sender: UIButton) {
    }
}

