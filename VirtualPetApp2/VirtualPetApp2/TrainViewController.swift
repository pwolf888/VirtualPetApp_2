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
    
    
    
    let brickWall = [UIImage(named:"1"),
                     UIImage(named:"2"),
                     UIImage(named:"3"),
                     UIImage(named:"4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let Wall = UIButton(frame: CGRect(x: -50, y: 150, width: 200, height: 200))
        Wall.setImage(brickWall[0], for: .normal)
        view.addSubview(Wall)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [])
        
        let vector = CGVector(dx: -0.3, dy: 0.0)
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        collision?.addItem(Wall)
    }
    @IBAction func trainTap(_ sender: UIButton) {
        Utilities.level += 1
        let love = UIButton(frame: CGRect(x: 300, y: 200, width: 50, height: 50))
        love.setImage(UIImage(named: "heart"), for: .normal)
        
        self.view.addSubview(love)
        gravity?.addItem((love as UIView))
        
        collision?.addItem(love)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
