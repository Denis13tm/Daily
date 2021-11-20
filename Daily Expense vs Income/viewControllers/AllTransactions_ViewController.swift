//
//  AllTransactions_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 15/11/2021.
//

import UIKit

class AllTransactions_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navigationBar_BV: UIView!
    @IBOutlet var noTransactionsView: UIView!
    @IBOutlet var table_View: UITableView!
    
    var allTransactions = [Transaction]()
    let realdb = RealmSwiftDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()

        
    }
    
    //MARK: - Methods...
    
    func initMethods() {
        
        allTransactions = realdb.getTransactions()
        
        
        
        modifierUI(ui: navigationBar_BV)
    }
    
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Table View...
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTransactions.count == 0 {
            table_View.isHidden = true
            noTransactionsView.isHidden = false
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
        if lastTransaction.type == "Expense ▼"{
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

            realdb.deleteTransaction(object: lastTransaction)
            allTransactions = realdb.getTransactions()
            table_View.reloadData()


        }
    }
    
    
    
    
    
    
}
