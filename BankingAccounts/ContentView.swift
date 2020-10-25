//
//  ContentView.swift
//  BankingAccounts
//
//  Created by Victor Castro on 24/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var bankAccountData = BankAccountViewModel()

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ListBankAccountsView(bankAccountData: bankAccountData)
    }
}

