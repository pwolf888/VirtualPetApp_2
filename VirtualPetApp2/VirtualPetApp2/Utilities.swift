//
//  Utilities.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 17/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit

class Utilities {
    
    
    private static var defaults  = UserDefaults.standard
    static var hunger: Int = 0
    static var happiness: Int = 0
    static var age : Int = 0
    static var level : Int = 0
    static var pooArray : [UIButton] = []
    
    static func loadDefaults() {
        hunger = defaults.integer(forKey: "Hunger")
        happiness = defaults.integer(forKey: "Happiness")
        age = defaults.integer(forKey: "Age")
        level = defaults.integer(forKey: "Level")
        pooArray = defaults.array(forKey: "Poo") as! [UIButton]
    }
    
    static func saveDefaults() {
        defaults.set(hunger, forKey: "Hunger")
        defaults.set(happiness, forKey: "Happiness")
        defaults.set(age, forKey: "Age")
        defaults.set(level, forKey: "Level")
        defaults.set(pooArray, forKey: "Poo")
    }

}
