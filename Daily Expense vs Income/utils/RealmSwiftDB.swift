//
//  Category_Items.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 18/11/2021.
//

import Foundation
import RealmSwift


class RealmSwiftDB {
    
    private let realm = try! Realm()
    private let defaults = DefaultsOfUser()
    
    func saveTransaction(object: Transaction) {
        
        realm.beginWrite()
        realm.add(object)
        try! realm.commitWrite()
        
    }
    
    func getTransactions() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listTransactions = [Transaction]()
        
        for singleT in transactions {
            listTransactions.append(singleT)
        }
        
        
        return listTransactions
        
    }
    
    func getExpProfit() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpProfit = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Income ▼" || singleT.type == "Kirim ▼" || singleT.type == "수입 ▼" {
                listExpProfit.append(singleT)
            }
        }
        return listExpProfit
        
    }
    
    func getExpCost() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpCost = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Expense ▼" || singleT.type == "Chiqim ▼" || singleT.type == "경비 ▼" {
                listExpCost.append(singleT)
            }
        }
        return listExpCost
        
    }
    
    
    func deleteTransaction(object: Transaction) {
        
        try! realm.write {
            realm.delete(object)
        }
        
        
    }
    
    func updateTransaction(object: Transaction, type: String, categoryLabel: String, categoryIcon: String, amount: String, date: String, notes: String) {
        
        try! realm.write {
            object.type = type
            object.category = categoryLabel
            object.icon = categoryIcon
            object.amount = amount
            object.date = date
            object.notes = notes
        }
        
    }
    
    
    
}
