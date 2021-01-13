//
//  DrinkController.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 13/01/2021.
//

import Foundation
import CoreData
import SwiftUI

// Création d'un Drink
func addDrink(drink: drinkType, date: Date, party: Party, sensation: String , using context: NSManagedObjectContext) {
    withAnimation {
        let newDrink = Drink(context: context)
        newDrink.amountOl = Int32(drink.amountOl)
        newDrink.date = date
        newDrink.name = drink.name
        newDrink.sensation = sensation
        newDrink.party = party
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
