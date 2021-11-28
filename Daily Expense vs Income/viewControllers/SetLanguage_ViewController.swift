//
//  SetLanguage_ViewController.swift
//  Daily Expense vs Income
//
//  Created by 13 Denis on 25/11/2021.
//

import UIKit

class SetLanguage_ViewController: UIViewController {

    @IBOutlet var title_label: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var baseLanguage_BV: UIView!
    @IBOutlet var bakgroundView: UIView!
    @IBOutlet var baseLanguage_: UILabel!
    @IBOutlet var languageRange: UIView!
    @IBOutlet var rangeBackground: UIStackView!
    @IBOutlet var nextBtn_BV: UIView!
    
    
    @IBOutlet var _ENG: UILabel!
    @IBOutlet var _KOR: UILabel!
    @IBOutlet var _UZB: UILabel!
    @IBOutlet var _RUS: UILabel!
    
    var title0 = "title0".localized()
    var description0 = "description0".localized()
    var langLabel = "LangLabel".localized()
    
    let defaults = DefaultsOfUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
    }
    
    @IBAction func nextBtn_Action(_ sender: Any) {
        defaults.saveLanguage(baseLanguage: baseLanguage_.text!)
    }
    
    
    //MARK: - Methods...
    
    func initViews() {
        
        setLangValue()
        setupLabelTap()
        
        baseLanguage_BV.layer.cornerRadius = 13.0
        rangeBackground.layer.cornerRadius = 13.0
        modifierUI(ui: rangeBackground)
        languageRange.layer.cornerRadius = 13.0
        bakgroundView.layer.cornerRadius = 13.0
        baseLanguage_.layer.cornerRadius = 13.0
        nextBtn_BV.layer.cornerRadius = 18.0
        modifierUI(ui: nextBtn_BV)
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    func setLangValue() {
        
        title_label.text = title0
        description_label.text = description0
        baseLanguage_.text = langLabel

    }
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! SetLanguage_ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupLabelTap() {

        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.baseLanguage_.isUserInteractionEnabled = true
        self.baseLanguage_.addGestureRecognizer(labelTap)

        }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        languageRange.isHidden.toggle()
        _ENG_Tapped()
        _KOR_Tapped()
        _UZB_Tapped()
        _RUS_Tapped()
        
    }
    

    
    func _ENG_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.engTapped))
        self._ENG.isUserInteractionEnabled = true
        self._ENG.addGestureRecognizer(labelTap)

        }

    @objc func engTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "ENG")
        baseLanguage_.text = "ENGLISH"
        Bundle.setLanguage(lang: "en")
        languageRange.isHidden.toggle()
        openScreen(vc: "SetLanguage_VC")
    }
    
    func _KOR_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.korTapped))
        self._KOR.isUserInteractionEnabled = true
        self._KOR.addGestureRecognizer(labelTap)

        }

    @objc func korTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "한")
        baseLanguage_.text = "한국어"
        Bundle.setLanguage(lang: "ko")
        languageRange.isHidden.toggle()
        openScreen(vc: "SetLanguage_VC")
    }
    
    func _UZB_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.uzbTapped))
        self._UZB.isUserInteractionEnabled = true
        self._UZB.addGestureRecognizer(labelTap)

        }

    @objc func uzbTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "UZB")
        baseLanguage_.text = "O'zbekcha"
        Bundle.setLanguage(lang: "uz")
        languageRange.isHidden.toggle()
        openScreen(vc: "SetLanguage_VC")
    }
    
    
    func _RUS_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.rusTapped))
        self._RUS.isUserInteractionEnabled = true
        self._RUS.addGestureRecognizer(labelTap)

        }

    @objc func rusTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "RUS")
        baseLanguage_.text = "Rусский"
        Bundle.setLanguage(lang: "ru")
        languageRange.isHidden.toggle()
        openScreen(vc: "SetLanguage_VC")
    }
    

}
