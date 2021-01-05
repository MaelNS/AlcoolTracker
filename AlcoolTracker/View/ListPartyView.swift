//
//  DataPartyView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 05/01/2021.
//

import SwiftUI

struct ListPartyView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Party.date, ascending: true)],
        animation: .default)
    private var partys: FetchedResults<Party>
    
    var body: some View {
        List {
            ForEach(partys) { party in
                NavigationLink(destination: DetailPartyView(party: party)) {
                    Text("\(party.date ?? Date())")
                }
            }
            .onDelete(perform: deleteParty)
        }
        .navigationTitle("Liste")
    }
    
    func deleteParty(offsets: IndexSet) {
        withAnimation {
            offsets.map { partys[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct DataPartyView_Previews: PreviewProvider {
    static var previews: some View {
        ListPartyView()
    }
}
