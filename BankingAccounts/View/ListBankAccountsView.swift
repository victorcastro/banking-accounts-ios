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
    
    @FetchRequest(entity: EntityBA.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], animation: .spring()) var results: FetchedResults<EntityBA>
    @Environment(\.managedObjectContext) var context
    
    @State private var nameBankAccount: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    VStack(alignment: .center, spacing: 20, content: {
                        TextField("Bank Name", text: $bankAccountData.bank).padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                        HStack {
                            TextField("Type", text: $bankAccountData.num1).keyboardType(.default).frame(width: 80, height: .none, alignment: .leading)
                            TextField("Number", text: $bankAccountData.num1).keyboardType(.numberPad)
                        }
                        HStack {
                            TextField("Type", text: $bankAccountData.num2).keyboardType(.default).frame(width: 80, height: .none, alignment: .leading)
                            TextField("Number Interbanking", text: $bankAccountData.num2).keyboardType(.numberPad)
                        }
                        Button(action: {
                                bankAccountData.writeData(context: context)
                                bankAccountData.bank = ""
                                bankAccountData.num1 = ""
                                bankAccountData.num2 = ""
                                UIApplication.shared.hideKeyboard()
                        }) {
                            HStack {
                                Text("Add new")
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                        .padding(15)
                    })
                }.font(.headline)
                Section(header: HStack{
                    Text("List Accounts")
                    Spacer()
                    EditButton()
                }) {
                    VStack(alignment: .leading, spacing: 10){
                        ForEach(results) { account in
                            HStack {
                                VStack(alignment: .leading, spacing: 10, content: {
                                    Text(account.bank ?? "Bank").font(.headline)
                                    Text(account.num1 ?? "Num1").font(.callout)
                                    Text(account.num2 ?? "Num2").font(.callout)
                                })
                                Spacer()
                                Button(action: share) {
                                    Image(systemName: "square.and.arrow.up.fill")
                                        .foregroundColor(.blue)
                                        .imageScale(.large)
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                            Divider()
                        }.onDelete(perform: delete)
                    }
                }
            }
            //.navigationBarItems(trailing: EditButton())
            .navigationTitle(Text("Bank Accounts"))
            .listStyle(PlainListStyle())
            //.listStyle(InsetGroupedListStyle())
        }
    }
    
    func delete(at offsets: IndexSet) {
        let deleteItem = results[offsets.first!]
        print("Delete \(offsets) ==> \(deleteItem)")
    }
    
    func share() {
        guard let data = URL(string: "https://victor.castrocontreras.com") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}


// extension for keyboard to dismiss
extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
