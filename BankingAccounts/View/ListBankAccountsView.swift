//
//  ContentView.swift
//  BankingAccounts
//
//  Created by Victor Castro on 24/10/20.
//

import SwiftUI
import CoreData

struct ListBankAccountsView: View {
    @ObservedObject var bankAccountData : BankAccountViewModel
    
    @FetchRequest(entity: EntityBankAccount.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], animation: .spring()) var results: FetchedResults<EntityBankAccount>
    @Environment(\.managedObjectContext) var context
    
    @State private var nameBankAccount: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new")) {
                    HStack {
                        TextField("Number Account", text: $bankAccountData.name)
                        Button(action: {
                                bankAccountData.writeData(context: context)
                                bankAccountData.name = ""
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                }.font(.headline)
                Section(header: Text("List Accounts")) {
                    VStack(alignment: .leading, spacing: 10){
                        ForEach(results) { accounts in
                            HStack(alignment: .top, spacing: 25, content: {
                                Text(accounts.name ?? "place")
                            })
                            
                        }
                    }
                }
            }
            .navigationTitle(Text("Bank Accounts"))
            .navigationBarItems(trailing: EditButton())
            .listStyle(InsetGroupedListStyle())
        }
    }
}


