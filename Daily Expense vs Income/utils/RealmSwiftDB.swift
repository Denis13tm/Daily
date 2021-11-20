
import Foundation
import RealmSwift


class RealmSwiftDB {
    
    private let realm = try! Realm()
    
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
            if singleT.type == "Income ▼" {
                listExpProfit.append(singleT)
            }
        }
        return listExpProfit
        
    }
    
    func getExpCost() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpCost = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Expense ▼" {
                listExpCost.append(singleT)
            }
        }
        return listExpCost
        
    }
    
    func calculateAllCost() -> [Transaction] {
        
        let transactions = realm.objects(Transaction.self)
        var listExpCost = [Transaction]()
        
        
        for singleT in transactions {
            if singleT.type == "Expense ▼" {
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
    
    
    
}
