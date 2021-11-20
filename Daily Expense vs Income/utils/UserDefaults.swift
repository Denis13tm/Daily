

import Foundation

public class DefaultsOfUser {
    
    let defaults =  UserDefaults.standard
    
    let passcode: String = "passcode"
    let cashBalance: String = "cashBalance"
    let currency: String = "currency"
    
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
    
}
