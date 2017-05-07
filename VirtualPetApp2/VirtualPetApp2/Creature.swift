//
//  Creature.swift
//  VirtualPetApp2
//
//  Created by Jonathan Turnbull on 7/05/2017.
//  Copyright © 2017 partywolfAPPS. All rights reserved.
//

import UIKit


class Creature: NSManagedObject {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
        Creature = try(context.fetch(Creature.fetchRequest()) as! [Creature])
    
    }
    catch {}
}
