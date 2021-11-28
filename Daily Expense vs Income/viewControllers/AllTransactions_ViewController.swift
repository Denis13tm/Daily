//
//  AllTransactions_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 15/11/2021.
//

import UIKit
import Lottie

class AllTransactions_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var navigationBar_BV: UIView!
    @IBOutlet var noTransactionsView: UIView!
    @IBOutlet var table_View: UITableView!
    @IBOutlet var noTranLabel: UILabel!
    
    
    var title7 = "title7".localized()
    var noTran = "noTran".localized()
    var expenseL = "expenseL".localized()
    var incomeL = "incomeL".localized()
    
    var allTransactions = [Transaction]()
    let realdb = RealmSwiftDB()
    let animationView = AnimationView()
    let defaults = DefaultsOfUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()

        
    }
    
    //MARK: - Methods...
    
    func initMethods() {
        
        allTransactions = realdb.getTransactions()
        
        title_label.text = title7
        noTranLabel.text = noTran
        
        modifierUI(ui: navigationBar_BV)
    }
    
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("data-scanning")
        animationView.frame = noTransactionsView.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        noTransactionsView.addSubview(animationView)
        
    }
    
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Table View...
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTransactions.count == 0 {
            table_View.isHidden = true
            noTransactionsView.isHidden = false
            setupAnimation()
        } else {
            table_View.isHidden = false
            noTransactionsView.isHidden = true
        }
        return allTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastTransaction = allTransactions[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("LastTransaction_TableViewCell", owner: self, options: nil)?.first as! LastTransaction_TableViewCell
        
        let icon = lastTransaction.icon

        cell.categoryImage.image = UIImage(systemName: icon)!
        cell.amout.text = lastTransaction.amount
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "경비 ▼" {
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        cell.notes.text = lastTransaction.notes
        cell.name.text = lastTransaction.category
        cell.date.text = lastTransaction.date
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            let lastTransaction = allTransactions[indexPath.row]
            
            var totalBalance = Int(defaults.getCashBalance()!)
            var income = Int(defaults.getIncome()!)
            var expense = Int(defaults.getExpense()!)
            
            if lastTransaction.type == (expenseL + " ▼") {
                totalBalance = totalBalance! + Int(lastTransaction.amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                expense = expense! - Int(lastTransaction.amount)!
                defaults.saveExpense(expense: String(expense!))
            } else if lastTransaction.type == (incomeL + " ▼") {
                totalBalance = totalBalance! + Int(lastTransaction.amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                income = income! + Int(lastTransaction.amount)!
                defaults.saveIncome(income: String(income!))
            }

            realdb.deleteTransaction(object: lastTransaction)
            allTransactions = realdb.getTransactions()
            table_View.reloadData()
            openHomeScreen(vc: "Home_VC")

        }
    }
    
    func openHomeScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
