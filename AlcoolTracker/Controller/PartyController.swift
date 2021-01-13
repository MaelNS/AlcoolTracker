//
//  PartyController.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 13/01/2021.
//

import Foundation
import CoreData
import SwiftUI

// Création d'une Party
func createNewParty(date: Date, using context: NSManagedObjectContext) {
    withAnimation {
        let newParty = Party(context: context)
        newParty.date = date
        newParty.isOver = false
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

// Ajout de la dateFin d'une Party et changement de la variable isOver
func endParty(date: Date, party: Party, using context: NSManagedObjectContext) {
    withAnimation {
        let newParty = party
        newParty.dateFin = date
        newParty.isOver = true
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
