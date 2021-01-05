//
//  DetailPartyView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 05/01/2021.
//

import SwiftUI

struct DetailPartyView: View {
    
    var party: Party
    
    var body: some View {
        List {
            ForEach(party.drink!.allObjects as! [Drink], id: \.self) { drink in
                Text(drink.name!)
            }

        }
        .navigationTitle("\(party.date!)")
    }
}

