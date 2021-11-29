

import Foundation
import UIKit

public class DefaultsOfUser {
    
    let defaults =  UserDefaults.standard
    
    let language: String = "language"
    let passcode: String = "passcode"
    let cashBalance: String = "cashBalance"
    let currency: String = "currency"
    let totalIncome: String = "totalIncome"
    let totalExpense: String = "totalExpense"
    let profileImage: String = "profileImage"
    
    //Base Language
    func saveLanguage(baseLanguage: String) {
        defaults.set(baseLanguage, forKey: language)
    }
    func getLanguage() -> String? {
        let baseLanguage = defaults.string(forKey: language)
        return baseLanguage
    }
    
    //Username
    func savePasscode(password: String) {
        defaults.set(password, forKey: passcode)
    }
    func getPasscode() -> String? {
        let password = defaults.string(forKey: passcode)
        return password
    }
    
    //Cash Balance
    func saveCashBalance(balance: String) {
        defaults.set(balance, forKey: cashBalance)
    }
    func getCashBalance() -> String? {
        let cashBalance = defaults.string(forKey: cashBalance)
        return cashBalance
    }
    
    //Base Currency
    func saveCurrency(baseCurrency: String) {
        defaults.set(baseCurrency, forKey: currency)
    }
    func getCurrency() -> String? {
        let baseCurrency = defaults.string(forKey: currency)
        return baseCurrency
    }
    
    //Total Income
    func saveIncome(income: String) {
        defaults.set(income, forKey: totalIncome)
    }
    func getIncome() -> String? {
        let income = defaults.string(forKey: totalIncome)
        return income
    }
    
    //Total Expense
    func saveExpense(expense: String) {
        defaults.set(expense, forKey: totalExpense)
    }
    func getExpense() -> String? {
        let expense = defaults.string(forKey: totalExpense)
        return expense
    }
    
    //Profile Image
    func saveProfileImage(image: String) {
        defaults.set(image, forKey: profileImage)
    }
    func getProfileImage() -> String? {
        let image = defaults.string(forKey: profileImage)
        return image
    }
    
}
