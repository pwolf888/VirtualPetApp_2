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

    
    @IBOutlet weak var hundredLabel: UILabel!
    
    @IBOutlet weak var Wall: UIButton!
    @IBOutlet weak var MonsterObject: UIImageView!
    
    let brickWall = [UIImage(named:"1"),
                     UIImage(named:"2"),
                     UIImage(named:"3"),
                     UIImage(named:"4")]
    
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
    @IBAction func trainTap(_ sender: UIButton) {
        hundred += 1
        hundredLabel.text = "\(hundred)"
        isHundred()
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
        if hundred == 60 {
            
            switch (timerSeconds) {
                case 0...10 :
                // do this
                    Utilities.xp += 20
                    addFireball()
                    breakWall(sender: Wall, imageIndex: brickWall[3]!)
                case 11...15:
                // do this
                    Utilities.xp += 15
                    addFireball()
                    breakWall(sender: Wall, imageIndex: brickWall[2]!)
                case 16...18:
                // do this
                    addFireball()
                    Utilities.xp += 10
                    breakWall(sender: Wall, imageIndex: brickWall[1]!)
                    default:
                        Utilities.xp -= 5
            }
            timerSeconds = 0
            hundred = 0
        }
        
    }
    
    func addFireball() {
        let love = UIButton(frame: CGRect(x: 300, y: 200, width: 50, height: 50))
        love.setImage(UIImage(named: "heart"), for: .normal)
        self.view.addSubview(love)
        gravity?.addItem((love as UIView))
       
        
    }
    
    func breakWall(sender: UIButton, imageIndex: UIImage) {
        
        UIView.animate(withDuration: 2.0,
                       animations: {sender.alpha = 0},
                       completion: { (true) in sender.setBackgroundImage(imageIndex, for: .normal)} )
        
        UIView.animate(withDuration: 2.0,
                       animations: {sender.alpha = 1},
                       completion: { (true) in sender.setBackgroundImage(self.brickWall[0], for: .normal)} )
        //sender.setBackgroundImage(brickWall[0], for: .normal)
    }
    
}
