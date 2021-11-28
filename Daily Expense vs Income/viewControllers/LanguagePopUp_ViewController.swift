//
//  LanguagePopUp_ViewController.swift
//  Daily Expense vs Income
//
//  Created by 13 Denis on 25/11/2021.
//

import UIKit

class LanguagePopUp_ViewController: UIViewController {
    
    @IBOutlet var non_View: UIView!
    
    @IBOutlet var english: UILabel!
    @IBOutlet var korean: UILabel!
    @IBOutlet var uzbek: UILabel!
    @IBOutlet var russian: UILabel!
    
    
    @IBOutlet var languageRange_BV: UIView!
    @IBOutlet var eng_BV: UIView!
    @IBOutlet var kor_BV: UIView!
    @IBOutlet var uz_BV: UIView!
    @IBOutlet var rus_BV: UIView!
    
    let defaults = DefaultsOfUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
    }
    @IBAction func closeViewBtn_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    
    func initViews() {
        nonView()
        setupLabelTap()
        languageRange_BV.layer.cornerRadius = 13.0
        modifierUI(ui: languageRange_BV)
        eng_BV.layer.cornerRadius = 18.0
        kor_BV.layer.cornerRadius = 18.0
        uz_BV.layer.cornerRadius = 18.0
        rus_BV.layer.cornerRadius = 18.0
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
    
    func nonView() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.nonViewTapped))
        self.non_View.isUserInteractionEnabled = true
        self.non_View.addGestureRecognizer(labelTap)

        }

    @objc func nonViewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupLabelTap() {

        _ENG_Tapped()
        _KOR_Tapped()
        _UZB_Tapped()
        _RUS_Tapped()

        }

    
    func _ENG_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.engTapped))
        self.english.isUserInteractionEnabled = true
        self.english.addGestureRecognizer(labelTap)

        }

    @objc func engTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "ENG")
        Bundle.setLanguage(lang: "en")
        openScreen(vc: "Home_VC")
    }
    
    func _KOR_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.korTapped))
        self.korean.isUserInteractionEnabled = true
        self.korean.addGestureRecognizer(labelTap)

        }

    @objc func korTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "한국어")
        Bundle.setLanguage(lang: "ko")
        openScreen(vc: "Home_VC")
    }
    
    func _UZB_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.uzbTapped))
        self.uzbek.isUserInteractionEnabled = true
        self.uzbek.addGestureRecognizer(labelTap)

        }

    @objc func uzbTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "UZB")
        Bundle.setLanguage(lang: "uz")
        openScreen(vc: "Home_VC")
    }
    
    func _RUS_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.rusTapped))
        self.russian.isUserInteractionEnabled = true
        self.russian.addGestureRecognizer(labelTap)

        }

    @objc func rusTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "РУС")
        Bundle.setLanguage(lang: "ru")
        openScreen(vc: "Home_VC")
    }
    
    

}
