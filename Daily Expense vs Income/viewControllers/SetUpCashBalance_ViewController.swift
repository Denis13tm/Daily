//
//  SetUpCashBalance_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 04/11/2021.
//

import UIKit

class SetUpCashBalance_ViewController: UIViewController {

    @IBOutlet var title_label: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var baseCurrency: UILabel!
    @IBOutlet var cashBalance: UITextField!
    @IBOutlet var nextBtnBackgroundView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    
    var title2 = "title2".localized()
    var description2 = "description2".localized()
    var currencyLabel = "currencyLabel".localized()
    
    let defaults = DefaultsOfUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        initViews()
        overrideUserInterfaceStyle = .light

    }
    
    //MARK: - Methods...
    
    func initViews() {
        setLangValue()
        baseCurrency.text = defaults.getCurrency()
        nextBtnBackgroundView.layer.cornerRadius = 18.0
        modifierUI(ui: nextBtnBackgroundView)
        backgroundView.layer.cornerRadius = 13.0
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    func setLangValue() {
        
        title_label.text = title2
        description_label.text = description2
        baseCurrency.text = currencyLabel
        

    }

    @IBAction func NextBtn_Action(_ sender: Any) {
        defaults.saveCashBalance(balance: cashBalance.text!)
        defaults.saveIncome(income: "0")
        defaults.saveExpense(expense: "0")
    }
    
   

}
