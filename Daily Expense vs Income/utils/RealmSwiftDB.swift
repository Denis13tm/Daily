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
            if singleT.type == "Income ▼" || singleT.type == "Kirim ▼" || singleT.type == "수입 ▼" || singleT.type == "Доход ▼" {
                listExpProfit.append(singleT)
            }
        }
        return listExpProfit
        
    }
    
    func getExpCost() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpCost = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Expense ▼" || singleT.type == "Chiqim ▼" || singleT.type == "경비 ▼" || singleT.type == "Расходы ▼" {
                listExpCost.append(singleT)
            }
        }
        return listExpCost
        
    }
    
//    func calculateCashFlow() {
//
//        let transactions = realm.objects(Transaction.self)
//        var listExpCost = [Transaction]()
//        var listExpProfit = [Transaction]()
//
//        let currentDate = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM.dd.yyyy"
//
//        var totalBalance = Int(defaults.getCashBalance()!)
//        var income = Int(defaults.getIncome()!)
//        var expense = Int(defaults.getExpense()!)
//
//        for singleT in transactions {
//            if singleT.type == "Expense ▼" {
//                listExpCost.append(singleT)
//                for exp in listExpCost {
//                    if currentDate >= exp.time! {
//                        totalBalance = totalBalance! - Int(exp.amount)!
//                        defaults.saveCashBalance(balance: String(totalBalance!))
//                        expense = expense! + Int(exp.amount)!
//                        defaults.saveExpense(expense: String(expense!))
//                        print("Expense ##########")
//                    } else {
//                        print("Upcoming Exp")
//                    }
//                }
//
//            } else if singleT.type == "Income ▼" {
//                listExpProfit.append(singleT)
//                for pro in listExpProfit {
//                    if currentDate >= pro.time! {
//                        totalBalance = totalBalance! + Int(singleT.amount)!
//                        defaults.saveCashBalance(balance: String(totalBalance!))
//                        income = income! + Int(singleT.amount)!
//                        defaults.saveIncome(income: String(income!))
//                        print("Income ##########")
//                    } else {
//                        print("Upcoming Income")
//                    }
//
//                }
//
//            }
//        }
//
//
//    }
    
    
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
