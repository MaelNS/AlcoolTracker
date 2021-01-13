//
//  ContentView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 04/01/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Party.allPartys)
    private var partys: FetchedResults<Party>

    var body: some View {
        HomeView(allPartys: partys)
    }
}
