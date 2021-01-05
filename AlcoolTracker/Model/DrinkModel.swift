//
//  DrinkModel.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 05/01/2021.
//

import Foundation

class drinkType {
    var name: String
    var percentOl: Int // %
    var quantity: Int // mL
    
    var amountOl: Int
    
    init(name: String, percentOl: Int, quantity: Int) {
        self.name = name
        self.percentOl = percentOl
        self.quantity = quantity
        self.amountOl = Int(Double(percentOl * quantity / 100) * 0.8) // g
    }
}

let drinks: [drinkType] = [
    drinkType(name: "Bière 25cL", percentOl: 5, quantity: 250),
    drinkType(name: "Bière 50cL", percentOl: 5, quantity: 500),
    drinkType(name: "Verre de vin", percentOl: 13, quantity: 120),
    drinkType(name: "Coktail léger", percentOl: 13, quantity: 200),
    drinkType(name: "Coktail fort", percentOl: 20, quantity: 200),
    drinkType(name: "Alcool pur", percentOl: 50, quantity: 50)
]
