//
//  SetUpCashBalance_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 04/11/2021.
//

import UIKit

class SetUpCashBalance_ViewController: UIViewController {

    @IBOutlet var baseCurrency: UILabel!
    @IBOutlet var cashBalance: UITextField!
    @IBOutlet var nextBtnBackgroundView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    
    let defaults = DefaultsOfUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initViews()

        
    }
    
    //MARK: - Methods...
    
    func initViews() {
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

    @IBAction func NextBtn_Action(_ sender: Any) {
        defaults.saveCashBalance(balance: cashBalance.text!)
    }
    
   

}
