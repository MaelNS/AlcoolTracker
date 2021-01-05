//
//  CurrentParty.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 04/01/2021.
//

import SwiftUI

struct CurrentParty: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Party.date, ascending: true)],
        animation: .default)
    private var partys: FetchedResults<Party>
    
    @State var showProfilView: Bool = false
    @State var partyRunning: Bool = false
    @State var action: Int? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !partyRunning {
                    Button(action: {
                        newParty(date: Date())
                        partyRunning = true
                    }) {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(.secondarySystemBackground))
                            .frame(height: 60)
                            .overlay(
                                HStack {
                                    Text("Nouvelle soirée")
                                    Spacer()
                                }
                                .padding()
                            )
                            .padding()
                    }
                }
                if partyRunning {
                    PartyRunningView()
                }
                NavigationLink(destination: ListPartyView(), tag: 1, selection: $action) { EmptyView() }
            }
            .navigationTitle("Soirée")
            .navigationBarItems(
                leading:
                Button(action: { showProfilView = true }) {
                    Image(systemName: "person.crop.circle")
                }
                .sheet(isPresented: $showProfilView) {
                    profilView()
                },
                trailing:
                Button(action: { action = 1 }) {
                    Text("Liste")
                }
            )
        }
    }
    
    func newParty(date: Date) {
        withAnimation {
            let newParty = Party(context: viewContext)
            newParty.date = date
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct PartyRunningView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Party.date, ascending: true)],
        animation: .default)
    private var partys: FetchedResults<Party>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Données")
                        .font(.headline)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                HStack {
                    Text("Nombre de verre : \(partys.last!.drink!.count)")
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    Text("Taux d'alcoolémie : \(calcAlcoolAmount()) g/L")
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            .padding()
            
            VStack {
                HStack {
                    Text("Je me serre :")
                        .font(.headline)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    ForEach(drinks, id: \.id) { drink in
                        Button(action: {
                            addNewDrink(drink: drink, date: Date())
                        }) {
                            Text(drink.name)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color(.tertiarySystemBackground)))
                        }
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            .padding()
            
            Button(action: { }) {
                Text("Fin soirée")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color(.secondarySystemBackground)))
            }
        }
    }
    
    func addNewDrink(drink: drinkType, date: Date) {
        withAnimation {
            let newDrink = Drink(context: viewContext)
            newDrink.amountOl = Int32(drink.amountOl)
            newDrink.date = date
            newDrink.name = drink.name
            newDrink.party = partys.last
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func calcAlcoolAmount() -> Int {
        var totalAmount = 0
        for drink in partys.last!.drink!.allObjects as! [Drink] {
            totalAmount += Int(drink.amountOl)
        }
        
        return totalAmount
    }
}

struct CurrentParty_Previews: PreviewProvider {
    static var previews: some View {
        CurrentParty()
    }
}
