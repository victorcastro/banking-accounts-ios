//
//  BankAccountViewModel.swift
//  BankingAccounts
//
//  Created by Victor Castro on 24/10/20.
//

import SwiftUI
import CoreData

class BankAccountViewModel: ObservableObject {
    @Published var bank = ""
    @Published var num1 = ""
    @Published var num2 = ""
    
    func writeData(context: NSManagedObjectContext) {
        let newBankAccount = EntityBA(context: context)
        newBankAccount.bank = bank
        newBankAccount.num1 = num1
        newBankAccount.num2 = num2
        
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
