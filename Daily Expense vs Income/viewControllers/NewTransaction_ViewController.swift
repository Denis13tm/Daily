//
//  NewTransaction_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 02/11/2021.
//

import UIKit

class NewTransaction_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var mainBackgroundView: UIScrollView!
    @IBOutlet var warningLabel: UILabel!
    
    @IBOutlet weak var navigationBar_BV: UIView!
    
    @IBOutlet weak var typeSection_BV: UIView!
    @IBOutlet weak var typeSelectorIndicator: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!

    @IBOutlet var categoryIcon: UIImageView!
    @IBOutlet weak var categoryLabel: UIButton!
    
    @IBOutlet weak var notesLabel: UITextField!
    @IBOutlet weak var expenseSelectLabel: UILabel!
    @IBOutlet weak var incomeSelectLabel: UILabel!
    @IBOutlet weak var typeSelector_BV: UIView!
    
    
    @IBOutlet weak var amountSection_BV: UIView!
    @IBOutlet weak var categorySection_BV: UIView!
    @IBOutlet weak var dateSection_BV: UIView!
    @IBOutlet weak var noteSection_BV: UIView!
    
    
    @IBOutlet var saveBtnBackgroundView: UIView!
    @IBOutlet var dateInputLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionView_BV: UIView!
    
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let realmDB = RealmSwiftDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initViews()

    }
    
    //MARK: - Methods...
    
    func initViews() {
        
        
        
        currencyLabel.text = defaults.getCurrency()
        if defaults1.string(forKey: "categoryIcon") != nil && defaults1.string(forKey: "categoryIcon") != "" {
            categoryIcon.image = UIImage(systemName: defaults1.string(forKey: "categoryIcon")!)
            categoryLabel.setTitle((defaults1.string(forKey: "categoryTitle")! + " ▼"), for: .normal)
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
        
        saveBtnBackgroundView.layer.cornerRadius = 18.0
        modifierUI(ui: saveBtnBackgroundView)
        
        
        
        collectionView_BV.layer.cornerRadius = 13.0
        modifierUI(ui: collectionView_BV)
        
        self.collectionView.register(UINib(nibName: "Category_CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Category_CollectionViewCell")
        
        
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
    
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveBtn_Action(_ sender: Any) {
        
    
        guard let type = typeSelectorIndicator.text else {
            warningLabel.isHidden = false
            warningLabel.text = "Select type please"
            return
        }
        
        guard let amount = amountTextField.text, amountTextField.text != ""  else {
            warningLabel.isHidden = false
            warningLabel.text = "Insert amount please"
            return
        }
        
        guard categoryLabel.title(for: .normal) != nil else {
            warningLabel.isHidden = false
            warningLabel.text = "Select category please"
            return
        }
        
        guard let date =  dateInputLabel.text, dateInputLabel.text != "" else {
            warningLabel.isHidden = false
            warningLabel.text = "Select date please"
            return
        }
        guard let notes = notesLabel.text, notesLabel.text != "" else {
            warningLabel.isHidden = false
            warningLabel.text = "Insert notes please"
            return
        }
        
        let newTransaction = Transaction()
        
        
        if defaults.getCurrency() == "USD"{
            if type == "Expense ▼" {
                newTransaction.amount = "- $" + amount
            } else if type == "Income ▼" {
                newTransaction.amount = "+ $" + amount
            }
        } else if defaults.getCurrency() == "KRW" {
            if type == "Expense ▼" {
                newTransaction.amount = "- " + amount + " won"
            } else if type == "Income ▼" {
                newTransaction.amount = "+ " + amount + " won"
            }
        } else if defaults.getCurrency() == "UZD"{
            if type == "Expense ▼" {
                newTransaction.amount = "- " + amount + " sum"
            } else if type == "Income ▼" {
                newTransaction.amount = "+ " + amount + " sum"
            }
        }
        
        newTransaction.icon = defaults1.string(forKey: "categoryIcon")!
        newTransaction.type = type
        newTransaction.category = defaults1.string(forKey: "categoryTitle")!
        newTransaction.date = date
        newTransaction.notes = notes
        
        realmDB.saveTransaction(object: newTransaction)
    
        openScreen(vc: "Home_VC")
        
    }
    
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //Type of Transaction...
    
    func setUpTransactionType() {

        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.typeSelectorIndicator.isUserInteractionEnabled = true
        self.typeSelectorIndicator.addGestureRecognizer(labelTap)

        }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        typeSelector_BV.isHidden.toggle()
        expanseTapped()
        incomeTapped()
        

    }


    func expanseTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.expenseSelected))
        self.expenseSelectLabel.isUserInteractionEnabled = true
        self.expenseSelectLabel.addGestureRecognizer(labelTap)
       

        }

    @objc func expenseSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorIndicator.text = expenseSelectLabel.text! + " ▼"
        typeSelector_BV.isHidden.toggle()
    }

    func incomeTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.incomeSelected))
        self.incomeSelectLabel.isUserInteractionEnabled = true
        self.incomeSelectLabel.addGestureRecognizer(labelTap)
        

        }

    @objc func incomeSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorIndicator.text = incomeSelectLabel.text! + " ▼"
        typeSelector_BV.isHidden.toggle()
        
    }
    
    
    //MARK: - Collection View...
    
    @IBAction func categoryBtn_Action(_ sender: Any) {
        mainBackgroundView.isHidden = true
        saveBtnBackgroundView.isHidden = true
        collectionView_BV.isHidden = false
    }
    
    
    var estimateWidth = 130.0
    var cellMarginSize = 13.0
    var category = Category_Items()
    
    func setUpGridView() {
        let flowLayout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
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
        
        categoryLabel.setTitle(userDefaults.string(forKey: "categoryTitle")! + " ▼", for: .normal)
        categoryIcon.image = UIImage(systemName: userDefaults.string(forKey: "categoryIcon")!)
        
        
        mainBackgroundView.isHidden = false
        saveBtnBackgroundView.isHidden = false
        collectionView_BV.isHidden = true
        
        
    }
    

    
    
    
}





extension NewTransaction_ViewController: UICollectionViewDelegateFlowLayout {
    
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
