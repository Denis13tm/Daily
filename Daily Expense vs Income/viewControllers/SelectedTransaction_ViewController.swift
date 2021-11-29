//
//  SelectedTransaction_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 22/11/2021.
//

import UIKit

class SelectedTransaction_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var navigationBar_BV: UIView!
    @IBOutlet var mainBackgroundView: UIScrollView!
    
    @IBOutlet var typeSection_BV: UIView!
    @IBOutlet var typeSelectorLabel: UILabel!
    
    @IBOutlet var typeSelector_BV: UIView!
    @IBOutlet var expenseSelectorLabel: UILabel!
    @IBOutlet var incomeSelectorLabel: UILabel!
    
    @IBOutlet var amountSection_BV: UIView!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    
    @IBOutlet var categorySection_BV: UIView!
    @IBOutlet var categoryIcon: UIImageView!
    @IBOutlet var selectCategoryBtn: UIButton!
    
    @IBOutlet var dateSection_BV: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var dateInputLabel: UILabel!
    
    @IBOutlet var noteSection_BV: UIView!
    @IBOutlet var noteTextField: UITextField!
    
    @IBOutlet var collectionView_BV: UIView!
    @IBOutlet var collection_View: UICollectionView!
    
    
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var saveBtn_BV: UIView!
    
    
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let realmDB = RealmSwiftDB()
    
    
    var selectedTransacion = Transaction()
    var type: String?
    var amount: String?
    var categoryImg: String?
    var categoryLabel: String?
    var date: String?
    var note: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        initViews()
        
    }
    


    // MARK: - Methods...
    
    @IBAction func backBtn_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func initViews() {
        
        
        
        currencyLabel.text = defaults.getCurrency()
        
        typeSelectorLabel.text = type
        amountTextField.text = amount
        categoryIcon.image = UIImage(systemName: categoryImg!)
        selectCategoryBtn.setTitle(categoryLabel, for: .normal)
        dateInputLabel.text = date
        noteTextField.text = note
        
        
        if defaults1.string(forKey: "categoryIcon") != nil && defaults1.string(forKey: "categoryIcon") != "" {
            categoryIcon.image = UIImage(systemName: defaults1.string(forKey: "categoryIcon")!)
            selectCategoryBtn.setTitle((defaults1.string(forKey: "categoryTitle")! + " ▼"), for: .normal)
        }
        
        
        setUpTransactionType()
        
        
        modifierUI(ui: navigationBar_BV)
        
        typeSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: typeSection_BV)
        modifierUI(ui: typeSelector_BV)
        
        amountSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: amountSection_BV)
        
        categorySection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: categorySection_BV)
        
        dateSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: dateSection_BV)
        
        noteSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: noteSection_BV)
        
        saveBtn_BV.layer.cornerRadius = 18.0
        modifierUI(ui: saveBtn_BV)
        
        
        
        collectionView_BV.layer.cornerRadius = 13.0
        modifierUI(ui: collectionView_BV)
        
        self.collection_View.register(UINib(nibName: "Category_CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Category_CollectionViewCell")
        
        
        setUpGridView()
        
    }

    
    @IBAction func datePicker_Action(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        dateInputLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    

    
    @IBAction func saveBtn_Action(_ sender: Any) {
        
    
        guard let type = typeSelectorLabel.text else {
            warningLabel.isHidden = false
            warningLabel.text = "Select type please"
            return
        }
        
        guard let amount = amountTextField.text, amountTextField.text != ""  else {
            warningLabel.isHidden = false
            warningLabel.text = "Insert amount please"
            return
        }
        
        guard selectCategoryBtn.title(for: .normal) != nil else {
            warningLabel.isHidden = false
            warningLabel.text = "Select category please"
            return
        }
        
        guard let date =  dateInputLabel.text, dateInputLabel.text != "" else {
            warningLabel.isHidden = false
            warningLabel.text = "Select date please"
            return
        }
        guard let notes = noteTextField.text, noteTextField.text != "" else {
            warningLabel.isHidden = false
            warningLabel.text = "Insert notes please"
            return
        }
        
        
        
        if defaults.getCurrency() == "USD"{
            if type == "Expense ▼" {
                selectedTransacion.amount = "- $" + amount
            } else if type == "Income ▼" {
                selectedTransacion.amount = "+ $" + amount
            }
        } else if defaults.getCurrency() == "KRW" {
            if type == "Expense ▼" {
                selectedTransacion.amount = "- " + amount + " won"
            } else if type == "Income ▼" {
                selectedTransacion.amount = "+ " + amount + " won"
            }
        } else if defaults.getCurrency() == "UZD"{
            if type == "Expense ▼" {
                selectedTransacion.amount = "- " + amount + " sum"
            } else if type == "Income ▼" {
                selectedTransacion.amount = "+ " + amount + " sum"
            }
        }
        

        
        //Calculation Stuff...
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"


        var totalBalance = Int(defaults.getCashBalance()!)
        var income = Int(defaults.getIncome()!)
        var expense = Int(defaults.getExpense()!)

        if currentDate == datePicker.date {
            if type == "Expense ▼" {
                totalBalance = totalBalance! - Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                expense = expense! + Int(amount)!
                defaults.saveExpense(expense: String(expense!))
                print("Current")
            } else if type == "Income ▼" {
                totalBalance = totalBalance! + Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                income = income! + Int(amount)!
                defaults.saveIncome(income: String(income!))
                print("Current")
            }
        } else if currentDate > datePicker.date {
            if type == "Expense ▼" {
                totalBalance = totalBalance! - Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                expense = expense! + Int(amount)!
                defaults.saveExpense(expense: String(expense!))
                print("Before expense")
            } else if type == "Income ▼" {
                totalBalance = totalBalance! + Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                income = income! + Int(amount)!
                defaults.saveIncome(income: String(income!))
                print("Before income")
            }
        } else if currentDate < datePicker.date {
            if type == "Expense ▼" {
                totalBalance = totalBalance! - Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                expense = expense! + Int(amount)!
                defaults.saveExpense(expense: String(expense!))
                print("After")
            } else if type == "Income ▼" {
                totalBalance = totalBalance! + Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                income = income! + Int(amount)!
                defaults.saveIncome(income: String(income!))
                print("After")
            }
        }
        

        realmDB.updateTransaction(object: selectedTransacion, type: type, categoryLabel: defaults1.string(forKey: "categoryTitle")!, categoryIcon: defaults1.string(forKey: "categoryIcon")!, amount: amount, date: date, notes: notes)
        openScreen(vc: "Home_VC")
    }
        
    func getCurrentDate() -> Date{
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return currentDate
    }
    
    func registerForNotification(type: String, date: Calendar) {
        
        // Notification content.
        let content = UNMutableNotificationContent()
        content.title = "Hi Boss"
        content.body = "Have you spent that amount of money today ?"
        
        //Date.
        var dateComponents = DateComponents()
        dateComponents.calendar = date
        
        
        //Create the tigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //Create the request.
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //Schedule the request with system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                //Handle any errors
                print("DEBUD: Register For Notification - \(String(describing: error))")
                
            }
        }
        
    }
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //Type of Transaction...
    
    func setUpTransactionType() {

        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.typeSelectorLabel.isUserInteractionEnabled = true
        self.typeSelectorLabel.addGestureRecognizer(labelTap)

        }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        typeSelector_BV.isHidden.toggle()
        expanseTapped()
        incomeTapped()
        

    }


    func expanseTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.expenseSelected))
        self.expenseSelectorLabel.isUserInteractionEnabled = true
        self.expenseSelectorLabel.addGestureRecognizer(labelTap)
       

        }

    @objc func expenseSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorLabel.text = expenseSelectorLabel.text! + " ▼"
        typeSelector_BV.isHidden.toggle()
    }

    func incomeTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.incomeSelected))
        self.incomeSelectorLabel.isUserInteractionEnabled = true
        self.incomeSelectorLabel.addGestureRecognizer(labelTap)
        

        }

    @objc func incomeSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorLabel.text = incomeSelectorLabel.text! + " ▼"
        typeSelector_BV.isHidden.toggle()
        
    }
    
    
    //MARK: - Collection View...
    
    @IBAction func categoryBtn_Action(_ sender: Any) {
        mainBackgroundView.isHidden = true
        saveBtn_BV.isHidden = true
        collectionView_BV.isHidden = false
    }
    
    
    var estimateWidth = 130.0
    var cellMarginSize = 13.0
    var category = Category_Items()
    
    func setUpGridView() {
        let flowLayout = collection_View?.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flowLayout.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = category.categoryItems[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category_CollectionViewCell", for: indexPath) as! Category_CollectionViewCell
        
        cell.title.text = item.title
        cell.image.image = UIImage(systemName: item.icon!)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = category.categoryItems[indexPath.row]
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(item.icon, forKey: "categoryIcon")
        userDefaults.set(item.title, forKey: "categoryTitle")
        
        selectCategoryBtn.setTitle(userDefaults.string(forKey: "categoryTitle")! + " ▼", for: .normal)
        categoryIcon.image = UIImage(systemName: userDefaults.string(forKey: "categoryIcon")!)
        
        
        mainBackgroundView.isHidden = false
        saveBtn_BV.isHidden = false
        collectionView_BV.isHidden = true
        
        
    }

    

}




extension SelectedTransaction_ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        return CGSize(width: width, height: width)
    }
    
    func calculateWidth() -> CGFloat {
        
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
}
