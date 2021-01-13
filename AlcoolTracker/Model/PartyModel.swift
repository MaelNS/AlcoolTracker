//
//  PartyModel.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 13/01/2021.
//

import Foundation
import CoreData
import SwiftUI

extension Party {
    
    // FetchRequest de toutes les Party
    static var allPartys: NSFetchRequest<Party> = {
        let request: NSFetchRequest<Party> = Party.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        return request
    }()
    
    // FetchRequest d'une Party en cours
    static var currentParty: NSFetchRequest<Party> = {
        let request: NSFetchRequest<Party> = Party.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = NSPredicate(format: "isOver == NO")
        
        return request
    }()
}
