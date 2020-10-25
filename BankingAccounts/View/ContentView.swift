//
//  ContentView.swift
//  BankingAccounts
//
//  Created by Victor Castro on 24/10/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(entity: EntityBankAccount.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],animation: .spring()) var results : FetchedResults<EntityBankAccount>
    @Environment(\.managedObjectContext) var context
    
    @State private var newBankAccount: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("What's next?")) {
                    HStack {
                        TextField("New Item", text: self.$newBankAccount)
                        Button(action: {
                            
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }
            }
            .navigationTitle(Text("SwiftUI"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
