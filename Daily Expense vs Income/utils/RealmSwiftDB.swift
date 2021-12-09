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
        do {
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
        
        
    }
    
    func getTransactions() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listTransactions = [Transaction]()
        
        for singleT in transactions {
//            listTransactions.append(singleT)
            listTransactions.insert(singleT, at: 0)
        }
        
        
        return listTransactions
        
    }
    
    func getExpProfit() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpProfit = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Income ▼" || singleT.type == "Kirim ▼" || singleT.type == "수입 ▼" {
                listExpProfit.insert(singleT, at: 0)
            }
        }
        return listExpProfit
        
    }
    
    func getExpCost() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpCost = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Expense ▼" || singleT.type == "Chiqim ▼" || singleT.type == "경비 ▼" {
                listExpCost.insert(singleT, at: 0)
            }
        }
        return listExpCost
        
    }
    
    
    func deleteTransaction(object: Transaction) {
        
        do {
            try realm.write {
        
                realm.delete(object)
                
            }
            
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
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
    func updateTransaction2(object: Transaction, type: String, categoryLabel: String, categoryIcon: String, amount: String, date: String, notes: String, isPresent: Bool, uuid: String, year: Int, month: Int, day: Int, hour: Int, minute: Int) {
        
        try! realm.write {
            object.type = type
            object.category = categoryLabel
            object.icon = categoryIcon
            object.amount = amount
            object.date = date
            object.notes = notes
            object.isPresent = isPresent
            object.uuid = uuid
            
            object.year = year
            object.month = month
            object.day = day
            object.hour = hour
            object.minute = minute
        }
        
    }
    
    func updateIsPresent(object: Transaction, isPresent: Bool) {
        
        try! realm.write {
            object.isPresent = isPresent
        }
        
    }
    
    
    
}
