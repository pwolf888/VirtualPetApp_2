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
    static var poo : Int = 0
    static var birthDate : Date = Date()
    static var lastOpen : Date = Date()
    static var xp : Int = 0
    
    static let monsterImages = [UIImage(named: "baby"),
                                UIImage(named: "toddler"),
                                UIImage(named: "teen"),
                                UIImage(named: "death")]
    
   
    
    static func loadDefaults() {
        
        hunger = defaults.integer(forKey: "Hunger")
        happiness = defaults.integer(forKey: "Happiness")
        age = defaults.integer(forKey: "Age")
        level = defaults.integer(forKey: "Level")
        
        poo = defaults.integer(forKey: "Poo")
        birthDate = (defaults.object(forKey: "BirthDate") as? Date)!
        lastOpen = (defaults.object(forKey: "LastOpen") as? Date)!
        xp = defaults.integer(forKey: "Xp")
        
    }
    
    static func saveDefaults() {
        defaults.set(hunger, forKey: "Hunger")
        defaults.set(happiness, forKey: "Happiness")
        defaults.set(age, forKey: "Age")
        defaults.set(level, forKey: "Level")
        defaults.set(poo, forKey: "Poo")
        defaults.set(birthDate, forKey:"BirthDate")
        defaults.set(lastOpen, forKey:"LastOpen")
        defaults.set(xp, forKey: "Xp")
        defaults.synchronize()
    }
    
    static func resetDefaults() {
        hunger = 10
        happiness = 10
        age = 0
        level = 0
        poo = 0
        birthDate = Date()
        lastOpen = Date()
        xp = 0
        saveDefaults()

    }
    
    
       
}
