//
//  ViewModel.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 13/01/2021.
//

import Foundation

// Volume total d'alcool ingéré
func getAlcoolAmount(party: Party) -> Int {
    var totalAmount = 0
    for drink in party.drink!.allObjects as! [Drink] {
        totalAmount += Int(drink.amountOl)
    }
    
    return totalAmount
}

// Taux d'alcoolémie
func getBloodAlcool(party: Party) -> String {
    let sex = UserDefaults.standard.string(forKey: "sex")
    let weight = UserDefaults.standard.integer(forKey: "weight")
    
    var diffusion: Double = 0
    if sex == "Femme" {
        diffusion = 0.6
    } else if sex == "Homme" {
        diffusion = 0.7
    }
    
    var bloodAlcool: Double = 0
    bloodAlcool = Double(getAlcoolAmount(party: party)) / (diffusion * Double(weight) )
    
    let stringBloodAlcool = String(format: "%.1f", bloodAlcool)
    return stringBloodAlcool
}
