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
    
    init(allPartys: FetchedResults<Party>) {
        if let lastParty = allPartys.last {
            if lastParty.dateFin == nil {
                _partyRunning = State<Bool>(initialValue: true)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !partyRunning {
                    Button(action: {
                        newParty(date: Date())
                        withAnimation() {
                            partyRunning = true
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(.secondarySystemBackground))
                            .frame(height: 60)
                            .overlay(
                                HStack {
                                    Text("Nouvelle soirée")
                                        .font(.system(.body, design: .rounded))
                                    Spacer()
                                }
                                .padding()
                            )
                            .padding()
                    }
                }
                if partyRunning {
                    PartyRunningView(partyRunning: self.$partyRunning)
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
                    profilView(showProfilView: self.$showProfilView)
                },
                trailing:
                Button(action: { action = 1 }) {
                    Text("Liste")
                        .font(.system(.body, design: .rounded))
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
    
    @Binding var partyRunning: Bool
    @State var selectedDrink: drinkType? = nil
    
    @State var showNewDrinkView: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Données")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top, 8)
            
            VStack(spacing: 4) {
                HStack{
                    Image(systemName: "drop.fill")
                        .foregroundColor(Color(.systemIndigo))
                    Text("Consommation")
                        .fontWeight(.bold)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color(.systemIndigo))
                        Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text("\(partys.last!.drink!.count)")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                    Text("verres bus")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color(.secondaryLabel))
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    Text("\(calcAlcoolAmount())")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                    Text("g d'alcool pur ingéré")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color(.secondaryLabel))
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            
            VStack {
                HStack{
                    Image(systemName: "cross.fill")
                        .foregroundColor(Color(.systemTeal))
                    Text("Taux d'alcoolémie")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemTeal))
                        Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text("\(calcBloodAlcool())")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                    Text("g/L")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color(.secondaryLabel))
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            
            VStack {
                HStack{
                    Image(systemName: "clock.fill")
                        .foregroundColor(Color(.systemPink))
                    Text("Evolution")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemPink))
                        Spacer()
                }
                .padding(.bottom, 8)
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(partys.last!.drink!.allObjects as! [Drink]) { drink in
                            VStack {
                                Text(sensationConvert[drink.sensation!]!)
                                Text(drink.sensation!)
                                Text(drink.name!)
                                Text("\(drink.date!, formatter: itemFormatter)")
                            }
                        }
                    }
                    .padding(.leading)
                }
            }
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.secondarySystemBackground))
            )
            
            HStack {
                Text("Consommation")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top, 8)
        }
        .padding(.horizontal)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(drinks, id: \.id) { drink in
                    Button(action: {
//                        addNewDrink(drink: drink, date: Date())
                        showNewDrinkView = true
                        selectedDrink = drink
                    }) {
                        VStack {
                            Text(drink.name)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.label))
                            Text("\(drink.amountOl)g alcool")
                                .font(.system(.callout, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(Color(.secondarySystemBackground)))
                    }
                    .sheet(isPresented: $showNewDrinkView) {
                        NewDrinkView(showNewDrinkView: self.$showNewDrinkView, selectedDrink: self.$selectedDrink)
                    }
                }
            }
            .padding(.leading)
        }
        
        Button(action: {
            endParty(date: Date())
            withAnimation() {
                partyRunning = false
            }
        }) {
            Text("Fin soirée")
                .padding()
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(Color(.secondarySystemBackground)))
        }
        .padding(.bottom)
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
    
    func calcBloodAlcool() -> String {
        let sex = UserDefaults.standard.string(forKey: "sex")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        
        var diffusion: Double = 0
        if sex == "Femme" {
            diffusion = 0.6
        } else if sex == "Homme" {
            diffusion = 0.7
        }
        
        var bloodAlcool: Double = 0
        bloodAlcool = Double(calcAlcoolAmount()) / (diffusion * Double(weight) )
        
        let stringBloodAlcool = String(format: "%.1f", bloodAlcool)
        return stringBloodAlcool
    }
    
    func endParty(date: Date) {
        withAnimation {
            let newParty = partys.last!
            newParty.dateFin = date
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()
