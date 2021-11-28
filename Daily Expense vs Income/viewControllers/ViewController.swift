//
//  ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 02/11/2021.
//

import UIKit
import Lottie

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navigationBarBackgroundView: UIView!
    @IBOutlet var localizationBtn: UIButton!
    
    @IBOutlet var main_img: UIImageView!
    
    @IBOutlet var totalMoney_view: UIImageView!
    @IBOutlet var totalBalance_title: UILabel!
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var baseCurrency: UILabel!
    @IBOutlet var incomeTitle: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var expenseTitle: UILabel!
    
    
    @IBOutlet var totalMoney_background: UIView!
    @IBOutlet var add: UIButton!
    
    
    @IBOutlet var transactions_BViewImage: UIImageView!
    @IBOutlet var transactions_BView: UIView!
    
    @IBOutlet var exp_profit_Btn: UIButton!
    @IBOutlet var transactions_Btn: UIButton!
    @IBOutlet var exp_cost_Btn: UIButton!
    
    @IBOutlet var exp_cost_BViewImage: UIImageView!
    @IBOutlet var exp_profit_BViewImage: UIImageView!
    @IBOutlet var exp_profit_BView: UIView!
    @IBOutlet var exp_cost_BView: UIView!
    
    @IBOutlet var lastTran: UILabel!
    @IBOutlet var viewAll_Btn: UIButton!
    @IBOutlet var today_label: UILabel!
    @IBOutlet var addnewTran_lebel: UILabel!
    @IBOutlet var bottomSide_View: UIView!
    
    @IBOutlet var noTransactionsView: UIView!
    @IBOutlet var table_View: UITableView!
    
    @IBOutlet var bottomSidesItemView: UIView!
    
    @IBOutlet var rightBtnBackgroundView: UIView!
    @IBOutlet var centerBtnBackgroundView: UIView!
    @IBOutlet var leftBtnBackgroundView: UIView!
    
    
    var total_Balance = "totalBalance".localized()
    var income = "income".localized()
    var expense = "expense".localized()
    var typeLabel = "typeLabel".localized()
    var expProfit = "expProfit".localized()
    var transaction = "transaction".localized()
    var expCost = "expCost".localized()
    var lastTranLabel = "lastTranLabel".localized()
    var viewAll = "viewAll".localized()
    var todayLabel = "todayLabel".localized()
    var addNewTranLabel = "addNewTranLabel".localized()
    var lang = "LangLabel".localized()
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    
    var transactionToShow = [Transaction]()
    let realdb = RealmSwiftDB()
    let animationView = AnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMethods()

    }
    //MARK: - Methods
    
    @IBAction func expectingProfitBtn_Action(_ sender: Any) {
        setSelectedProfitBtn()
    }
    @IBAction func lastTrasactionsBtn_Action(_ sender: Any) {
        setSelectedTransactionBtn()
    }
    @IBAction func expectingCostBtn_Action(_ sender: Any) {
        setSelectedCostBtn()
    }
    
    
    //...Set up selesctedbutton background view
    func setSelectedProfitBtn() {
        exp_profit_BViewImage.image = UIImage(named: "gradiantBV")
        transactions_BViewImage.image = UIImage(named: "")
        exp_cost_BViewImage.image = UIImage(named: "")
        
        exp_profit_Btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        exp_cost_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        transactions_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        
        transactionToShow = realdb.getExpProfit()
        table_View.reloadData()
    }
    func setSelectedTransactionBtn() {
        exp_profit_BViewImage.image = UIImage(named: "")
        transactions_BViewImage.image = UIImage(named: "gradiantBV")
        exp_cost_BViewImage.image = UIImage(named: "")
        
        transactions_Btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        exp_cost_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        exp_profit_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        
        transactionToShow = realdb.getTransactions()
        table_View.reloadData()
    }
    func setSelectedCostBtn() {
        exp_profit_BViewImage.image = UIImage(named: "")
        transactions_BViewImage.image = UIImage(named: "")
        exp_cost_BViewImage.image = UIImage(named: "gradiantBV")
        
        exp_cost_Btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        transactions_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        exp_profit_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        
        transactionToShow = realdb.getExpCost()
        table_View.reloadData()
    }
    
    
    func initMethods() {
        setLangValue()
        initViewsModifier()
        registerForNotification()
        
    }
    
    func setLangValue() {
        
        localizationBtn.setTitle(lang, for: .normal)
        totalBalance_title.text = total_Balance
        incomeTitle.text = income
        expenseTitle.text = expense
        exp_profit_Btn.setTitle(expProfit, for: .normal)
        transactions_Btn.setTitle(transaction, for: .normal)
        exp_cost_Btn.setTitle(expCost, for: .normal)
        lastTran.text = lastTranLabel
        viewAll_Btn.setTitle(viewAll, for: .normal)
        today_label.text = todayLabel
        addnewTran_lebel.text = addNewTranLabel

    }
    
    func registerForNotification() {
        
        // Notification content.
        let content = UNMutableNotificationContent()
        content.title = "Hi "
        content.body = "Did you check your cash balance today"
        
        //Date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 20
        dateComponents.minute = 30
        
        
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
      
    
    func initViewsModifier() {
        
        localizationBtn.setTitle(defaults.getLanguage(), for: .normal)
        
        transactionToShow = realdb.getTransactions()
        
        modifierUI(ui: navigationBarBackgroundView)
        main_img.layer.cornerRadius = 22.0
        localizationBtn.layer.cornerRadius = 8.0

        totalMoney_view.layer.cornerRadius = 22.0
        
        totalBalance.text = Int(defaults.getCashBalance()!)?.formattedWithSeparator
        baseCurrency.text = defaults.getCurrency()
        incomeLabel.text = Int(defaults.getIncome()!)?.formattedWithSeparator
        expenseLabel.text = Int(defaults.getExpense()!)?.formattedWithSeparator
        

        
        totalMoney_background.layer.cornerRadius = 22.0
        modifierUI(ui: totalMoney_background)



        exp_profit_BViewImage.layer.cornerRadius = 18.0
        exp_profit_BView.layer.cornerRadius = 18.0



        transactions_BViewImage.layer.cornerRadius = 18.0
        transactions_BView.layer.cornerRadius = 18.0



        exp_cost_BViewImage.layer.cornerRadius = 18.0
        exp_cost_BView.layer.cornerRadius = 18.0

        bottomSide_View.layer.cornerRadius = 22.0
        modifierUI(ui: bottomSide_View)
       
        bottomSidesItemView.layer.cornerRadius = 18.0
        modifierUI(ui: bottomSidesItemView)
        
        rightBtnBackgroundView.layer.cornerRadius = 13.0
        centerBtnBackgroundView.layer.cornerRadius = 13.0
        leftBtnBackgroundView.layer.cornerRadius = 13.0
        
        
        
    }
    
    func setValueOfLanguage() {
        
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("data-scanning")
        animationView.frame = noTransactionsView.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        noTransactionsView.addSubview(animationView)
        
    }
    
    

    
    @IBAction func addBtn_Action(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NewTransaction_VC") as! NewTransaction_ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func viewAllBtn_Action(_ sender: Any) {
        openScreen(vc: "AllTransactions_ VC")
    }
    
    func openScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! AllTransactions_ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    //MARK: - Table View...
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if transactionToShow.count == 0 {
            table_View.isHidden = true
            noTransactionsView.isHidden = false
            setupAnimation()
        } else {
            table_View.isHidden = false
            noTransactionsView.isHidden = true
            noTransactionsView.isUserInteractionEnabled = true
        }
        
        if transactionToShow.count >= 8 {
            return 8
        } else {
            return transactionToShow.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastTransaction = transactionToShow[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("LastTransaction_TableViewCell", owner: self, options: nil)?.first as! LastTransaction_TableViewCell
        
        let icon = lastTransaction.icon
        cell.categoryImage.image = UIImage(systemName: icon)!
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Income ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyUS
        } else if lastTransaction.type == "경비 ▼" || lastTransaction.type == "수입 ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyKR
        } else if lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "Kirim ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyUZ
        } else if lastTransaction.type == "Расходы ▼" || lastTransaction.type == "Доход ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyRU
        }
        
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "경비 ▼" || lastTransaction.type == "Расходы ▼" {
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        cell.notes.text = lastTransaction.notes
        cell.name.text = lastTransaction.category
        cell.date.text = lastTransaction.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lastTransaction = transactionToShow [indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(identifier: "SelectedTransaction_VC") as! SelectedTransaction_ViewController

        
        vc.selectedTransacion = lastTransaction
        vc.amount = lastTransaction.amount
        vc.categoryImg = lastTransaction.icon
        vc.categoryLabel = lastTransaction.category
        vc.type = lastTransaction.type
        vc.date = lastTransaction.date
        vc.note = lastTransaction.notes
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let expenseL = "expenseL".localized()
        let incomeL = "incomeL".localized()
        
        var totalBalance = Int(defaults.getCashBalance()!)
        var income = Int(defaults.getIncome()!)
        var expense = Int(defaults.getExpense()!)
        
        func showActionSheet() {
            
            let actionsheet = UIAlertController(title: "Would you like to delete this transaction?", message: nil, preferredStyle: .actionSheet)
            
            actionsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                let lastTransaction = self.transactionToShow[indexPath.row]

                if lastTransaction.type == (expenseL + " ▼") {
                    totalBalance = totalBalance! + Int(lastTransaction.amount)!
                    self.defaults.saveCashBalance(balance: String(totalBalance!))
                    expense = expense! - Int(lastTransaction.amount)!
                    self.defaults.saveExpense(expense: String(expense!))
                } else if lastTransaction.type == (incomeL + " ▼") {
                    totalBalance = totalBalance! - Int(lastTransaction.amount)!
                    self.defaults.saveCashBalance(balance: String(totalBalance!))
                    income = income! + Int(lastTransaction.amount)!
                    self.defaults.saveIncome(income: String(income!))
                }

                self.realdb.deleteTransaction(object: lastTransaction)
                self.transactionToShow = self.realdb.getTransactions()
                self.table_View.reloadData()
                self.openHomeScreen(vc: "Home_VC")
            }))
            
            actionsheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            }))
            
            present(actionsheet, animated: true)
            
        }
        
        if editingStyle == .delete {
            
            showActionSheet()

        }
        
    }
    
    
    func openHomeScreen(vc: String) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc) as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

    

 


}

extension Formatter {
    static let number = NumberFormatter()
}
extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
    static let koreaKR: Locale = .init(identifier: "ko_KR")
    static let uzbek: Locale = .init(identifier: "uz_Latn_UZ")
    static let russianRU: Locale = .init(identifier: "ru_RU")
    // ... and so on
}
extension Numeric {
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }
    // Localized
    var currency:   String { formatted(style: .currency) }
    // Fixed locales
    var currencyUS: String { formatted(style: .currency, locale: .englishUS) }
    var currencyKR: String { formatted(style: .currency, locale: .koreaKR) }
    var currencyUZ: String { formatted(style: .currency, locale: .uzbek) }
    var currencyRU: String { formatted(style: .currency, locale: .russianRU) }

}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
