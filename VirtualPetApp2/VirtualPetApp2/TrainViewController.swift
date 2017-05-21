//
//  TrainViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 14/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController {
    
    // Declared variables.
    var gravity : UIGravityBehavior?
    var animator : UIDynamicAnimator?
    var collision : UICollisionBehavior?
    var hundred = 0
    var timerSeconds = 0
    let timerSecondsMax = 19
    var timer = Timer()
    
    // IBOutlets for Labels
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var hundredLabel: UILabel!
    @IBOutlet weak var Wall: UIButton!
    @IBOutlet weak var MonsterObject: UIButton!
    
    // bricwall images
    let brickWall = [UIImage(named:"1"),
                     UIImage(named:"2"),
                     UIImage(named:"3"),
                     UIImage(named:"4")]
    
    // Fireball images
    let fireBalls = [UIImage(named:"fireballs1"),
                      UIImage(named:"fireballs2"),
                      UIImage(named:"fireballs3")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [])
        
        let vector = CGVector(dx: -5.0, dy: 0.0)
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        
        runTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lvlLabel.text = "LVL\(Utilities.level)"
        evolutionCheck()
    }
    // Tap the button to play the mini game, get up to 60 as fast as possible
    @IBAction func trainTap(_ sender: UIButton) {
        hundred += 1
        hundredLabel.text = "\(hundred)"
        isSixty()
        
        // For testing perposes
        //Utilities.level += 1
        lvlLabel.text = "LVL\(Utilities.level)"
        evolutionCheck()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Simple timer
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
    }
    
    // Update the timer
    func updateTimer() {
        if timerSeconds == timerSecondsMax {
            timerSeconds = 0
            
        } else {
            timerSeconds += 1
        }
    }
    
    // Checks the timing of the training minigame and what wall to break and points given out.
    func isSixty() {
        if hundred == 60 {
            
            switch (timerSeconds) {
                case 0...10 :
                // do this
                    Utilities.xp += 20
                    addFireball(fireImage: fireBalls[2]!)
                    breakWall(sender: Wall, imageIndex: brickWall[3]!)
                    message.text = "Awesome! 20XP"
                    
                case 11...15:
                // do this
                    Utilities.xp += 15
                    addFireball(fireImage: fireBalls[1]!)
                    breakWall(sender: Wall, imageIndex: brickWall[2]!)
                    message.text = "Good! 15XP"
                case 16...18:
                // do this
                    addFireball(fireImage: fireBalls[0]!)
                    Utilities.xp += 10
                    breakWall(sender: Wall, imageIndex: brickWall[1]!)
                    message.text = "Ok! 10XP"
                    default:
                        Utilities.xp -= 5
                        message.text = "Try again! -5XP"
            }
            timerSeconds = 0
            hundred = 0
            if Utilities.xp >= 100 {
                Utilities.level = Utilities.xp / 100
            }
            lvlLabel.text  = "LVL \(Utilities.level)"
        }
        
    }
    
    // Depending on the timing of the shot a different fireball image is chosen
    func addFireball(fireImage: UIImage) {
        let fireball = UIButton(frame: CGRect(x: 300, y: 250, width: 50, height: 50))
        fireball.setImage(fireImage, for: .normal)
        self.view.addSubview(fireball)
        gravity?.addItem((fireball as UIView))
       
        
    }
    
    // Animates the wall when the monster shoots at it
    func breakWall(sender: UIButton, imageIndex: UIImage) {
        
        UIView.animate(withDuration: 2.0,
                       animations: {sender.alpha = 0},
                       completion: { (true) in sender.setBackgroundImage(imageIndex, for: .normal)} )
        
        UIView.animate(withDuration: 2.0,
                       animations: {sender.alpha = 1},
                       completion: { (true) in sender.setBackgroundImage(self.brickWall[0], for: .normal)} )
        
    }
    
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
    
}
