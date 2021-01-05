//
//  CurrentParty.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 04/01/2021.
//

import SwiftUI

struct CurrentParty: View {
    @State var partyRunning: Bool = false
    @State var showNewDrink: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                Rectangle()
                    .frame(width: 200, height: 400)
                    .foregroundColor(.blue)
                Rectangle()
                    .frame(width: 200, height: 400)
                    .foregroundColor(.green)
                Rectangle()
                    .frame(width: 200, height: 400)
                    .foregroundColor(.red)
            }
            .navigationTitle("Home")
            .navigationBarItems(trailing:
                Button(action: {
                    showNewDrink = true
                }) {
                    Text("New drink")
                }
                .sheet(isPresented: $showNewDrink) {
                    Text("Aaa")
                }
            )
        }
    }
}

struct CurrentParty_Previews: PreviewProvider {
    static var previews: some View {
        CurrentParty()
    }
}
