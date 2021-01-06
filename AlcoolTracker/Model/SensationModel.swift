//
//  SensationModel.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 06/01/2021.
//

import Foundation

class sensationType {
    let id = UUID()
    let name: String
    let icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
}

let sensations: [sensationType] = [
    sensationType(name: "Bien", icon: "🙂"),
    sensationType(name: "Très bien", icon: "😃"),
    sensationType(name: "Exité", icon: "😜"),
    sensationType(name: "Trop exité", icon: "🤪"),
    sensationType(name: "Malade", icon: "🤢")
]

var sensationConvert: [String: String] = ["Bien": "🙂", "Très bien": "😃", "Exité": "😜", "Trop exité": "🤪", "Malade": "🤢"]

