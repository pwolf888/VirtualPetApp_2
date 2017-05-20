//
//  TrainViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 14/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController {

    var gravity : UIGravityBehavior?
    var animator : UIDynamicAnimator?
    var collision : UICollisionBehavior?
    var hundred = 0
    var timerSeconds = 0
    let timerSecondsMax = 19
    var timer = Timer()
    
    @IBOutlet weak var lvlLabel: UILabel!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var hundredLabel: UILabel!
    
    @IBOutlet weak var Wall: UIButton!
    
    @IBOutlet weak var MonsterObject: UIButton!
    let brickWall = [UIImage(named:"1"),
                     UIImage(named:"2"),
                     UIImage(named:"3"),
                     UIImage(named:"4")]
    
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
    }
    
    @IBAction func trainTap(_ sender: UIButton) {
        hundred += 1
        hundredLabel.text = "\(hundred)"
        isHundred()
        Utilities.level += 1
        evolutionCheck()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
    }
    
    func updateTimer() {
        if timerSeconds == timerSecondsMax {
            timerSeconds = 0
            
        } else {
            timerSeconds += 1
        }
    }
    
    func isHundred() {
        if hundred == 10 {
            
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
        }
        
    }
    
    func addFireball(fireImage: UIImage) {
        let fireball = UIButton(frame: CGRect(x: 300, y: 250, width: 50, height: 50))
        fireball.setImage(fireImage, for: .normal)
        self.view.addSubview(fireball)
        gravity?.addItem((fireball as UIView))
       
        
    }
    
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
        switch (Utilities.level) {
            
        case 5...9:
            MonsterObject.setImage(Utilities.monsterImages[0], for: .normal)
        case 10...19:
            MonsterObject.setImage(Utilities.monsterImages[1], for: .normal)
            
        case 20...100:
            MonsterObject.setImage(Utilities.monsterImages[2], for: .normal)
            
        default:
            MonsterObject.setImage(UIImage(named:"egg"), for: .normal)
            
        }
    }
    
    
}
