//
//  CurrencyConverter_ViewController.swift
//  Daily Expense vs Income
//
//  Created by 13 Denis on 04/12/2021.
//

import UIKit

class CurrencyConverter_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceLabel_BV: UIView!
    @IBOutlet var title_Label: UILabel!
    
    
    @IBOutlet var mainView_BV: UIView!
    @IBOutlet var amount_TextField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    
    
    @IBOutlet var backgroundView_1: UIView!
    @IBOutlet var backgroundView_2: UIView!
    
    var title9 = "title9".localized()
    var amount_placeholder = "amount_placeholder".localized()
    
    var currencyCode: [String] = []
    var values: [Double] = []
    var activeCurrency = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        overrideUserInterfaceStyle = .light
        initViews()

        
    }
    

    
    // MARK: - Methods...
    
    func initViews() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        fetchJSON()
        amount_TextField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
        
        mainView_BV.layer.cornerRadius = 18.0
        modifierUI(ui: mainView_BV)
        priceLabel_BV.layer.cornerRadius = 18.0
        modifierUI(ui: priceLabel_BV)
        backgroundView_1.layer.cornerRadius = 18.0
        backgroundView_2.layer.cornerRadius = 18.0
        
        title_Label.text = title9
        amount_TextField.placeholder = amount_placeholder
        
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateViews(input: Double) {
        
        guard let amountText = amount_TextField.text, let theAmountText = Double(amountText) else { return }
        if amount_TextField.text != ""{
            let total = theAmountText * activeCurrency
            priceLabel.text = String(format: "%.2f", total)
            
        }
    }
    
    //MARK: - Picker View...
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyCode[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = values[row]
        updateViews(input: activeCurrency)
    }
    
    
    func fetchJSON() {

        guard let url = URL(string: "https://open.exchangerate-api.com/v6/latest") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //handling any errors if there ara any
            if error != nil {
                print(error!)
                return
            }

            //safely unwrap the data
            guard let safeDate = data else { return }

            //decode JSON Data
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeDate)
                self.currencyCode.append(contentsOf: results.rates.keys)
                self.values.append(contentsOf: results.rates.values)
            } catch {
                print(error)
            }
        }.resume()

    }

    

}
