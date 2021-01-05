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

    var body: some View {
        CurrentParty()
    }
}
