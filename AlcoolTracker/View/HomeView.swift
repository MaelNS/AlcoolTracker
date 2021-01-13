//
//  CurrentParty.swift
//  AlcoolTracker
//
//  Created by Maël Navarro Salcedo on 04/01/2021.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Party.currentParty)
    private var currentParty: FetchedResults<Party>
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
                        createNewParty(date: Date(), using: viewContext)
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
                    PartyRunningView(partyRunning: self.$partyRunning, currentParty: currentParty.last!)
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
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()
