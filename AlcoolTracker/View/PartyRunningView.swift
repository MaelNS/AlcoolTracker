//
//  PartyRunningView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 13/01/2021.
//

import SwiftUI

struct PartyRunningView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedDrink: drinkType? = nil
    @State var showNewDrinkView: Bool = false
    @Binding var partyRunning: Bool
    var currentParty: Party
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    
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
                    Text("\(currentParty.drink!.count)")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                    Text("verres bus")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color(.secondaryLabel))
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    Text("\(getAlcoolAmount(party: currentParty))")
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
                    Text("\(getBloodAlcool(party: currentParty))")
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
                        ForEach(currentParty.drink!.allObjects as! [Drink]) { drink in
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
                        NewDrinkView(showNewDrinkView: self.$showNewDrinkView, selectedDrink: self.$selectedDrink, currentParty: currentParty).environment(\.managedObjectContext, self.viewContext)
                    }
                }
            }
            .padding(.leading)
        }
        
        Button(action: {
            withAnimation() {
                partyRunning = false
            }
            endParty(date: Date(), party: currentParty, using: viewContext)
        }) {
            Text("Fin soirée")
                .padding()
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(Color(.secondarySystemBackground)))
        }
        .padding(.bottom)
    }
}

