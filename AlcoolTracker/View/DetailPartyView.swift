//
//  DetailPartyView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 05/01/2021.
//

import SwiftUI

struct DetailPartyView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    var drinks: FetchRequest<Drink>
    var date: Date
    
    init(date: Date) {
        self.date = date
        self.drinks = FetchRequest<Drink>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Drink.date, ascending: true)]
            ,predicate: NSPredicate(format: "party.date = %@", date as NSDate)
        )
    }
    
    var body: some View {
        List {
            ForEach(drinks.wrappedValue) { drink in
                Text(drink.name!)
            }
            .onDelete(perform: deleteDrink)

        }
        .navigationTitle("\(date)")
    }
    
    private func deleteDrink(offsets: IndexSet) {
        withAnimation {
            offsets.map { drinks.wrappedValue[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

