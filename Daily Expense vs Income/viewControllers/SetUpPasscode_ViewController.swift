//
//  SetUpPasscode_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 16/11/2021.
//

import UIKit

class SetUpPasscode_ViewController: UIViewController {
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var headline_label: UILabel!
    @IBOutlet var enter_pw: UILabel!
    @IBOutlet var confirm_pw: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var newPasscode: UITextField!
    @IBOutlet var confirmedPasscode: UITextField!
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var nextBtn_Action: UIView!
    @IBOutlet var backgroundView: UIView!
    
    var title3 = "title3".localized()
    var errorLabel = "errorLabel".localized()
    var headline = "headline".localized()
    var enterPassword = "enterPassword".localized()
    var confirmPassword = "confirmPassword".localized()
    var description3 = "description3".localized()
    var digits = "digits".localized()
    
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initViews()
        overrideUserInterfaceStyle = .light
    }
    
    func initViews() {
        setLangValue()
        
        nextBtn_Action.layer.cornerRadius = 18.0
        modifierUI(ui: nextBtn_Action)
        backgroundView.layer.cornerRadius = 13.0
        
        setUp_texField()
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    func setLangValue() {
        
        title_label.text = title3
        description_label.text = description3
        headline_label.text = headline
        enter_pw.text = enterPassword
        confirm_pw.text = confirmPassword
        warningLabel.text = errorLabel
        newPasscode.placeholder = digits
        confirmedPasscode.placeholder = digits

    }
    
    func setUp_texField() {
    
        self.newPasscode.delegate = self
        self.confirmedPasscode.delegate = self
    
        self.newPasscode.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.confirmedPasscode.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        
    
    }
    
    @objc func changeCharacter() {
        warningLabel.isHidden = true
    }
    
    
    @IBAction func nextBtn_Action(_ sender: Any) {
        

        
        if newPasscode.text?.utf8.count == 4 && confirmedPasscode.text?.utf8.count == 4 {
            
            if newPasscode.text == confirmedPasscode.text {
                
                if !newPasscode.text!.isEmpty || !confirmedPasscode.text!.isEmpty {
                    
                    defaults.savePasscode(password: newPasscode.text!)
                    openScreen(vc: "OTP_VC")
                    
                }
            } else {
                warningLabel.text = "Passwords don't match. Please try again."
                warningLabel.isHidden = false
            }
    
        } else {
            warningLabel.text = "Please enter only 4 digits password."
            warningLabel.isHidden = false
        }
        

        
    }
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    

}


extension SetUpPasscode_ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.utf16.count == 4 && !string.isEmpty {
            return false
        } else {
            return true
        }
    }
    
}
