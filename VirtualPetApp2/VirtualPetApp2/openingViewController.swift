//
//  openingViewController.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 20/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit

class openingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func green(_ sender: UIButton) {
        Utilities.greenTrue = true
    }
  
    @IBAction func red(_ sender: UIButton) {
        Utilities.redTrue = true
    }

    @IBAction func blue(_ sender: UIButton) {
        Utilities.blueTrue = true
    }
}
