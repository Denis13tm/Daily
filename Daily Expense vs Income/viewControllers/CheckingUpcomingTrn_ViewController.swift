//
//  CheckingUpcomingTrn_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Tuychiev Otabek on 03/12/2021.
//

import UIKit

class CheckingUpcomingTrn_ViewController: UIViewController {
    
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var body_label: UILabel!
    
    @IBOutlet var main_BV: UIView!
    @IBOutlet var noAndDeleteBtn_BV: UIView!
    @IBOutlet var yesIdidBtn_BV: UIView!
    
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let realmDB = RealmSwiftDB()
    var transactions = [Transaction]()
    var upcomingTrn = [Transaction]()
    
    var selectedTransaction = Transaction()
    var isChecked: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        InitViews()
    }
    
    
    //MARK: - Methods...
    
    @IBAction func noAndDeleteBtn_Action(_ sender: Any) {
        
        showUpTrn_AlertAction(body: "Are you sure to delete this transaction", object: selectedTransaction)
        
    }
    
    @IBAction func yesIdidBtn_Action(_ sender: Any) {
        
        realmDB.updateTransaction2(object: selectedTransaction, type: selectedTransaction.type, categoryLabel: selectedTransaction.category, categoryIcon: selectedTransaction.icon, amount: selectedTransaction.amount, date: selectedTransaction.date, notes: selectedTransaction.notes, isPresent: false, uuid: selectedTransaction.uuid, year: selectedTransaction.year, month: selectedTransaction.month, day: selectedTransaction.day, hour: selectedTransaction.hour, minute: selectedTransaction.minute)
        
        var totalBalance_cal = Int(defaults.getCashBalance()!)
        var income_cal = Int(defaults.getIncome()!)
        var expense_cal = Int(defaults.getExpense()!)
        
        if selectedTransaction.isUpcoming == true && selectedTransaction.isPresent != true {
            if selectedTransaction.type == "Income ▼" || selectedTransaction.type == "Kirim ▼" || selectedTransaction.type == "수입 ▼" {
                totalBalance_cal = totalBalance_cal! + Int(selectedTransaction.amount)!
                defaults.saveCashBalance(balance: String(totalBalance_cal!))
                income_cal = income_cal! + Int(selectedTransaction.amount)!
                defaults.saveIncome(income: String(income_cal!))
                print("DONE1")
                
            } else if selectedTransaction.type == "Expense ▼" || selectedTransaction.type == "Chiqim ▼" || selectedTransaction.type == "경비 ▼" {
                totalBalance_cal = totalBalance_cal! - Int(selectedTransaction.amount)!
                defaults.saveCashBalance(balance: String(totalBalance_cal!))
                expense_cal = expense_cal! + Int(selectedTransaction.amount)!
                defaults.saveExpense(expense: String(expense_cal!))
                defaults.saveIncome(income: String(income_cal!))
                print("DONE2")
            }
        }
        
        
        openScreen(vc: "Home_VC")
    }
    
    func InitViews() {
        
        main_BV.layer.cornerRadius = 13.0
        modifierUI(ui: main_BV)
        noAndDeleteBtn_BV.layer.cornerRadius = 18.0
        yesIdidBtn_BV.layer.cornerRadius = 18.0
        
    }
    
    
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    
    func openScreen(vc: String?) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc!)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    func showUpTrn_AlertAction(body: String, object: Transaction) {
        let alert = UIAlertController(title: "Confirm your decision please", message: body, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] action in
            realmDB.deleteTransaction(object: object)
            openScreen(vc: "Home_VC")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { [self] action in
            openScreen(vc: "Home_VC")
        }))
        
        present(alert, animated: true)
    }
    
    
    

}

