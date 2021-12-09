//
//  Profile_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 10/11/2021.
//

import UIKit

class Profile_ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var about_label: UILabel!
    @IBOutlet var explaination_label: UILabel!
    
    
    @IBOutlet var totalBalance_Edition: UILabel!
    @IBOutlet var incomeLabel_Edition: UILabel!
    @IBOutlet var expenseLabel_Edition: UILabel!
    
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var incomeVsExpense_BV: UIView!
    @IBOutlet var expense_BV: UIView!
    @IBOutlet var income_BV: UIView!
    @IBOutlet var daily_income_label: UILabel!
    @IBOutlet var daily_expense_label: UILabel!
    
    @IBOutlet var totalBalance_CardView_label: UILabel!
    @IBOutlet var totalBalance_BV: UIView!
    @IBOutlet var leftSideOfTotalB_BV: UIView!
    
    @IBOutlet var cancelBtn_BV: UIView!
    @IBOutlet var saveChangesBtn_BV: UIView!
    @IBOutlet var editBtn_BV: UIView!
    
    @IBOutlet var cancel_Btn: UIButton!
    @IBOutlet var save_Btn: UIButton!
    @IBOutlet var edit_Btn: UIButton!
    
    @IBOutlet var BtnsGroup_BV: UIStackView!
    
    
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var totalBalance_Label: UILabel!
    
    
    @IBOutlet var editionGroup_BV: UIView!
    @IBOutlet var totalSection: UIView!
    @IBOutlet var incomeSection: UIView!
    @IBOutlet var expenseSection: UIView!
    
    @IBOutlet var totalBalanceEditionLabel: UITextField!
    @IBOutlet var incomeEditionLabel: UITextField!
    @IBOutlet var expenseEditionLabel: UITextField!
    
    
    
    var title8 = "title8".localized()
    var dailyIncome = "dailyIncome".localized()
    var dailyExpenses = "dailyExpenses".localized()
    var totalBalance_CardView = "totalBalance_CardView".localized()
    var about = "about".localized()
    var explanation = "explanation".localized()
    var editBtn = "editBtn".localized()
    var totalBalanceEdition = "totalBalance_Edition".localized()
    var income_Edition = "income_Edition".localized()
    var expense_Edition = "expense_Edition".localized()
    var cancelBtn = "cancelBtn".localized()
    var saveChangesBtn = "saveChangesBtn".localized()
    
    
    let defaults = DefaultsOfUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        initViews()
        overrideUserInterfaceStyle = .light
    }
    
    
    //MARK: - Methods...
    
    func initViews() {
        
        
        setLangValue()
        
        totalBalanceEditionLabel.placeholder = Int(defaults.getCashBalance()!)?.formattedWithSeparator
        incomeEditionLabel.placeholder = Int(defaults.getIncome()!)?.formattedWithSeparator
        expenseEditionLabel.placeholder = Int(defaults.getExpense()!)?.formattedWithSeparator
        
        let img = defaults.getProfileImage()
        
        if img != nil && img != ""{
            profileImage.image = defaults.getProfileImage()?.toImage()
        }
        
        incomeLabel.text = Int(defaults.getIncome()!)?.formattedWithSeparator
        expenseLabel.text = Int(defaults.getExpense()!)?.formattedWithSeparator
        currencyLabel.text = defaults.getCurrency()
        totalBalance_Label.text = Int(defaults.getCashBalance()!)?.formattedWithSeparator
        
        
        
        expense_BV.layer.cornerRadius = 18.0
        modifierUI(ui: incomeVsExpense_BV)
        income_BV.layer.cornerRadius = 18.0
        
        totalBalance_BV.layer.cornerRadius = 18.0
        modifierUI(ui: totalBalance_BV)
        leftSideOfTotalB_BV.layer.cornerRadius = 18.0
        
        cancelBtn_BV.layer.cornerRadius = 18.0
        modifierUI(ui: cancelBtn_BV)
        saveChangesBtn_BV.layer.cornerRadius = 18.0
        modifierUI(ui: saveChangesBtn_BV)
        editBtn_BV.layer.cornerRadius = 18.0
        modifierUI(ui: editBtn_BV)
        
        editionGroup_BV.layer.cornerRadius = 18.0
        modifierUI(ui: editionGroup_BV)
        totalSection.layer.cornerRadius = 18.0
        modifierUI(ui: totalSection)
        incomeSection.layer.cornerRadius = 18.0
        modifierUI(ui: incomeSection)
        expenseSection.layer.cornerRadius = 18.0
        modifierUI(ui: expenseSection)
        
    }
    
    func setLangValue() {
        
        title_label.text = title8
        daily_income_label.text = dailyIncome
        daily_expense_label.text = dailyExpenses
        totalBalance_CardView_label.text = totalBalance_CardView
        about_label.text = about
        explaination_label.text = explanation
        edit_Btn.setTitle(editBtn, for: .normal)
        totalBalance_Edition.text = totalBalanceEdition
        incomeLabel_Edition.text = income_Edition
        expenseLabel_Edition.text = expense_Edition
        cancel_Btn.setTitle(cancelBtn, for: .normal)
        save_Btn.setTitle(saveChangesBtn, for: .normal)
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5
    }

    @IBAction func imagePickerBtn_Action(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    @IBAction func editBtn_Action(_ sender: Any) {
        incomeVsExpense_BV.isHidden = true
        BtnsGroup_BV.isHidden = false
        editBtn_BV.isHidden = true
        BtnsGroup_BV.isHidden = false
        totalBalance_BV.isHidden = true
        editionGroup_BV.isHidden = false
        
        animatedBtn(btn: cancelBtn_BV ?? (Any).self)
        animatedBtn(btn: saveChangesBtn_BV ?? (Any).self)
        animatedBtn(btn: editionGroup_BV ?? (Any).self)
        
    }
    
    public func animatedBtn(btn: Any) {
        let button = btn as! UIView
        let bounds = button.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            button.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width + 50, height: bounds.size.height)
        }) { (success: Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: {
                    button.bounds = bounds
                })
            }
            
        }
        
    }
    
    
    
    @IBAction func cancelBtn_Action(_ sender: Any) {
        incomeVsExpense_BV.isHidden = false
        BtnsGroup_BV.isHidden = true
        editBtn_BV.isHidden = false
        BtnsGroup_BV.isHidden = true
        totalBalance_BV.isHidden = false
        editionGroup_BV.isHidden = true
        
        animatedBtn(btn: editBtn_BV ?? (Any).self)
        animatedBtn(btn: incomeVsExpense_BV ?? (Any).self)
        animatedBtn(btn: totalBalance_BV ?? (Any).self)
    }
    
    @IBAction func saveChangesBtn_Action(_ sender: Any) {
        incomeVsExpense_BV.isHidden = false
        BtnsGroup_BV.isHidden = true
        editBtn_BV.isHidden = false
        BtnsGroup_BV.isHidden = true
        totalBalance_BV.isHidden = false
        editionGroup_BV.isHidden = true
        

        
        if totalBalanceEditionLabel.text != nil && totalBalanceEditionLabel.text != ""{
            defaults.saveCashBalance(balance: totalBalanceEditionLabel.text!)
        } else {
            defaults.saveCashBalance(balance: defaults.getCashBalance()!)
        }
        
        if incomeEditionLabel.text != nil && incomeEditionLabel.text != ""{
            defaults.saveIncome(income: incomeEditionLabel.text!)
        } else {
            defaults.saveIncome(income: defaults.getIncome()!)
        }
        
        if expenseEditionLabel.text != nil && expenseEditionLabel.text != ""{
            defaults.saveExpense(expense: expenseEditionLabel.text!)
        } else {
            defaults.saveExpense(expense: defaults.getExpense()!)
        }
        
        
        
        openScreen(vc: "Home_VC")
    }
    
    
    @IBAction func backBtn_Action(_ sender: Any) {
        
        if imgSelected == true {
            openScreen(vc: "Home_VC")
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    var imgSelected: Bool?

}


extension Profile_ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImage.image = image
            defaults.saveProfileImage(image: image.toPngString()!)
            imgSelected = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
