//
//  profilView.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 05/01/2021.
//

import SwiftUI

struct profilView: View {
    @State var toggleSex = true
    @State var weight = 65
    @Binding var showProfilView: Bool
    
    init(showProfilView: Binding<Bool>) {
        let sexUD = UserDefaults.standard.string(forKey: "sex") ?? ""
        let weightUD = UserDefaults.standard.integer(forKey: "weight")
        
        if sexUD == "Femme" {
            _toggleSex = State<Bool>(initialValue: true)
        } else if sexUD == "Homme" {
            _toggleSex = State<Bool>(initialValue: false)
        }
        
        _weight = State<Int>(initialValue: weightUD)
        
        _showProfilView = showProfilView
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Profil")
                    .font(.title).fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text("Je suis :")
                Spacer()
                Button(action: {
                    withAnimation() {
                        toggleSex.toggle()
                    }
                }) {
                    Text(toggleSex ? "Femme" : "Homme")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color(.secondarySystemBackground)))
                }

            }
            Stepper(value: $weight) {
                HStack {
                    Text("Je pèse: \(weight)")
                    Spacer()
                }
            }
            Spacer()
            Button(action: {
                saveProfil(sex: toggleSex, weight: weight)
            }) {
                Text("Sauvegarder")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color(.secondarySystemBackground)))
            }
        }
        .padding()
    }
    
    func saveProfil(sex: Bool, weight: Int) {
        var sexString = ""
        if sex {
            sexString = "Femme"
        } else {
            sexString = "Homme"
        }
        UserDefaults.standard.set(sexString, forKey: "sex")
        UserDefaults.standard.set(weight, forKey: "weight")
        showProfilView = false
    }
}
