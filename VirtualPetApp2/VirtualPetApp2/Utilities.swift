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
    static var birthDate : Date = Date()

    static func loadDefaults() {
        
        
        hunger = defaults.integer(forKey: "Hunger")
        happiness = defaults.integer(forKey: "Happiness")
        age = defaults.integer(forKey: "Age")
        level = defaults.integer(forKey: "Level")
        
        if let loadArray = defaults.array(forKey: "Poo") {
            pooArray = loadArray as! [UIButton]
        }

        
        birthDate = (defaults.object(forKey: "BirthDate") as? Date)!
    }
    
    static func saveDefaults() {
        defaults.set(hunger, forKey: "Hunger")
        defaults.set(happiness, forKey: "Happiness")
        defaults.set(age, forKey: "Age")
        defaults.set(level, forKey: "Level")
        defaults.set(pooArray, forKey: "Poo")
        defaults.set(birthDate, forKey:"BirthDate")
        defaults.synchronize()
    }
    
    static func resetDefaults() {
        hunger = 10
        happiness = 10
        age = 0
        level = 0
        pooArray = []
        birthDate = Date()
        
        saveDefaults()
        
        
        
    }
}
