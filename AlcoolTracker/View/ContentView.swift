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
        TabView {
            CurrentParty()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Bbb")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Data")
                }
            Text("Bbb")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("My account")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
