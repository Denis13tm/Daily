//
//  SelectedTransaction_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 22/11/2021.
//

import UIKit

class SelectedTransaction_ViewController: UIViewController {
    
    @IBOutlet var navigationBar_BV: UIView!
    @IBOutlet var mainBackgroundView: UIScrollView!
    
    @IBOutlet var typeSection_BV: UIView!
    @IBOutlet var typeSelectorLabel: UILabel!
    
    
    @IBOutlet var amountSection_BV: UIView!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    
    @IBOutlet var categorySection_BV: UIView!
    @IBOutlet var categoryIcon: UIImageView!
    @IBOutlet var selectCategoryBtn: UIButton!
    
    @IBOutlet var dateSection_BV: UIView!
    
    @IBOutlet var dateInputLabel: UILabel!
    
    @IBOutlet var noteSection_BV: UIView!
    @IBOutlet var noteTextField: UILabel!
    

    
    
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let realmDB = RealmSwiftDB()
    
    
    var selectedTransacion = Transaction()
    var type: String?
    var amount: String?
    var categoryImg: String?
    var category_Label: String?
    var date: String?
    var note: String?
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var type_label: UILabel!
    
    @IBOutlet var amount_label: UILabel!
    @IBOutlet var category_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var notes_label: UILabel!

   
    
    
    
    
    var title5 = "title5".localized()
    var type1 = "type".localized()
    var typeLabel = "typeLabel".localized()
    var expenseL = "expenseL".localized()
    var incomeL = "incomeL".localized()
    var amount1 = "amount".localized()
    var category_ = "category".localized()
    var categorylabel = "categoryLabel".localized()
    var date1 = "date".localized()
    var setDate = "setDate".localized()
    var notes = "notes".localized()
    var notePlaceholder = "notePlaceholder".localized()
    var errorLabel = "error".localized()
    var saveBtn_label = "saveBtn".localized()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        initViews()
        overrideUserInterfaceStyle = .light
        
    }
    


    // MARK: - Methods...
    
    @IBAction func backBtn_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func initViews() {
        
        setLangValue()
        
        currencyLabel.text = defaults.getCurrency()
        
        typeSelectorLabel.text = type
        amountTextField.text = amount
        categoryIcon.image = UIImage(systemName: categoryImg!)
        selectCategoryBtn.setTitle(category_Label, for: .normal)
        dateInputLabel.text = date
        noteTextField.text = note
        
        
        if defaults1.string(forKey: "categoryIcon") != nil && defaults1.string(forKey: "categoryIcon") != "" {
            categoryIcon.image = UIImage(systemName: defaults1.string(forKey: "categoryIcon")!)
            selectCategoryBtn.setTitle((defaults1.string(forKey: "categoryTitle")! + " ▼"), for: .normal)
        }
        
        
        modifierUI(ui: navigationBar_BV)
        
        typeSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: typeSection_BV)
       
        
        amountSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: amountSection_BV)
        
        categorySection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: categorySection_BV)
        
        dateSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: dateSection_BV)
        
        noteSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: noteSection_BV)
        
    }
    
    
    func setLangValue() {
        
        title_label.text = title5
        type_label.text = type1
        amount_label.text = amount1
        category_label.text = category_
        date_label.text = date1
        dateInputLabel.text = setDate
        notes_label.text = notes
        
    }
    

    

    
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    


    
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

    

}



