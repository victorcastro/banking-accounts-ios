//
//  BankAccountViewModel.swift
//  BankingAccounts
//
//  Created by Victor Castro on 24/10/20.
//

import SwiftUI
import CoreData

class BankAccountViewModel: ObservableObject {
    @Published var name = ""
    @Published var number: Int32 = 0
    
    func writeData(context: NSManagedObjectContext) {
        let newBankAccount = EntityBankAccount(context: context)
        newBankAccount.name = name
        newBankAccount.number = number
        
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
