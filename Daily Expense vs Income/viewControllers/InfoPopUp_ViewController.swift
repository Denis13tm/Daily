//
//  InfoPopUp_ViewController.swift
//  Daily Expense vs Income
//
//  Created by 13 Denis on 08/12/2021.
//

import UIKit

class InfoPopUp_ViewController: UIViewController {

    
    @IBOutlet var main_BV: UIView!
    @IBOutlet var body_BV: UIView!
    
    @IBOutlet var info_Label: UILabel!
    
    var isIncomeInfo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
    }
    

   
    // MARK: - Methods...
    
    func initViews() {
        main_BV.layer.cornerRadius = 13.0
        modifierUI(ui: main_BV)
        body_BV.layer.cornerRadius = 13.0
        
        
        if isIncomeInfo == true {
            info_Label.text = "This is all your incomes so far, and the whole upcoming transactions will be included after your checking that you receive or spend these transactions. Please do not forget to check your upcoming transactions."
        } else {
            info_Label.text = "This is all your expenses so far, and the whole upcoming transactions will be included after your checking that you receive or spend these transactions. Please do not forget to check your upcoming transactions."
        }
        
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }

    @IBAction func closeBtn_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
