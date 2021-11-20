//
//  SetUpBaseCurrency_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 04/11/2021.
//

import UIKit


class SetUpBaseCurrency_ViewController: UIViewController {


    @IBOutlet weak var baseCurrency_: UILabel!
    @IBOutlet var nextBtnBackgroundView: UIView!
    @IBOutlet var bakgroundView: UIView!

    @IBOutlet weak var currencyRange: UIView!
    
    @IBOutlet weak var _USD: UILabel!
    @IBOutlet weak var _WON: UILabel!
    @IBOutlet weak var _UZD: UILabel!
    
    @IBOutlet weak var rangeBackground: UIStackView!
    
    
    let defaults = DefaultsOfUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
    }
    
    
    //MARK: - Methods...
    
    func initViews() {
        
        setupLabelTap()
        
        
        rangeBackground.layer.cornerRadius = 13.0
        modifierUI(ui: rangeBackground)
        currencyRange.layer.cornerRadius = 13.0
        bakgroundView.layer.cornerRadius = 13.0
        baseCurrency_.layer.cornerRadius = 13.0
        nextBtnBackgroundView.layer.cornerRadius = 18.0
        modifierUI(ui: nextBtnBackgroundView)
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    func setupLabelTap() {

        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.baseCurrency_.isUserInteractionEnabled = true
        self.baseCurrency_.addGestureRecognizer(labelTap)

        }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        currencyRange.isHidden.toggle()
        _USD_Tapped()
        _WON_Tapped()
        _UZD_Tapped()
        
    }
    

    
    func _USD_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.USDTapped))
        self._USD.isUserInteractionEnabled = true
        self._USD.addGestureRecognizer(labelTap)

        }

    @objc func USDTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveCurrency(baseCurrency: _USD.text!)
        baseCurrency_.text = _USD.text
        currencyRange.isHidden.toggle()
    }
    
    func _WON_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.WONTapped))
        self._WON.isUserInteractionEnabled = true
        self._WON.addGestureRecognizer(labelTap)

        }

    @objc func WONTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveCurrency(baseCurrency: _WON.text!)
        baseCurrency_.text = _WON.text
        currencyRange.isHidden.toggle()
    }
    
    func _UZD_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.UZDTapped))
        self._UZD.isUserInteractionEnabled = true
        self._UZD.addGestureRecognizer(labelTap)

        }

    @objc func UZDTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveCurrency(baseCurrency: _UZD.text!)
        baseCurrency_.text = _UZD.text
        currencyRange.isHidden.toggle()
    }
    
    
    

    @IBAction func nextBtn_Action(_ sender: Any) {
        defaults.saveCurrency(baseCurrency: baseCurrency_.text!)
    }
    
    
    
    
    
}
