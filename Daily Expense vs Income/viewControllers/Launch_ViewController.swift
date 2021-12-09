//
//  Launch_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 08/11/2021.
//

import UIKit

class Launch_ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var launching_label: UILabel!
    
    var launching = "launching".localized()
    
    public let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        overrideUserInterfaceStyle = .light
    }
    
    
    
// MARK: - Methods...
    
    func initViews() {
        launching_label.text = launching
        backgroundImageView.layer.cornerRadius = backgroundImageView.bounds.height / 3.5

        getPermissonOfNC()
    }
    
     func getPermissonOfNC() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)in
            
            DispatchQueue.main.async { [self] in
                
                let language = userDefaults.string(forKey: "language")
                let cashBalance = userDefaults.string(forKey: "cashBalance")
                let baseCurrency = userDefaults.string(forKey: "currency")
                let passcode = userDefaults.string(forKey: "passcode")
                
                if language != nil && language != "" {
                    
                    if baseCurrency != nil && baseCurrency != "" {

                        if cashBalance != nil && cashBalance != "" {

                            if passcode != nil && passcode != "" {

                                openScreen(vc: "OTP_VC")

                            } else {

                                openScreen(vc: "Passcode_VC")
                            }

                        } else {

                            openScreen(vc: "CashBalance_VC")
                        }

                    } else {

                    openScreen(vc: "BaseCurrency_VC")
                        
                    }
                } else {
                    
                    openScreen(vc: "SetLanguage_VC")
                    
                }

                
            }
            
        }
    }
    
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }

}


// Put this piece of code anywhere you like to hide default keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

