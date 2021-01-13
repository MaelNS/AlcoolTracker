//
//  NewDrinkView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 06/01/2021.
//

import SwiftUI

struct NewDrinkView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var tagSelection: String = ""
    @Binding var showNewDrinkView: Bool
    @Binding var selectedDrink: drinkType?
    var currentParty: Party
    var sensation: sensationType? = nil
    var column: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Nouvelle consommation")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack {
                    Text("Verre")
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
                        Text(selectedDrink!.name)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("\(selectedDrink!.amountOl)")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                        Text("g d'alcool pur")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.secondaryLabel))
                        Spacer()
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.secondarySystemBackground))
                )
            }
            .padding()
            .padding(.top)
            
            HStack {
                Text("Comment te sens-tu ?")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top, 8)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sensations, id: \.id) { sensation in
                        ButtonView(sensation: sensation, tagSelection: $tagSelection)
                    }
                }
                .padding(.leading)
            }
            
            Spacer()
            
            Button(action: {
                if tagSelection != "" {
                    addDrink(drink: selectedDrink!, date: Date(), party: currentParty, sensation: tagSelection, using: viewContext)
                    showNewDrinkView = false
                }
            }) {
                Text("Sauvegarder")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(.secondarySystemBackground))
                    )
            }
            .padding(.bottom)
        }
    }
}

struct ButtonView: View {
    var sensation: sensationType
    @Binding var tagSelection: String
    
    var body: some View {
        VStack {
            Text(sensation.icon)
                .font(.system(.title))
            Text(sensation.name)
                .font(.system(.body, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(.secondaryLabel))
            
        }
        .frame(width: 60, height: 80)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(isSelected(tagSelection: tagSelection, sensation: sensation) ? .tertiarySystemBackground : .secondarySystemBackground))
        )
        .onTapGesture {
            tagSelection = sensation.name
        }
    }
    
    private func isSelected(tagSelection: String, sensation: sensationType) -> Bool {
        var isSelected = false
        if tagSelection == sensation.name {
            isSelected = true
        } else {
            isSelected = false
        }
        return isSelected
    }
}
