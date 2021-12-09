//
//  ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 02/11/2021.
//

import UIKit
import Lottie
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate, CellActionDelegate {
    
    
    
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
    var upcomingTrn = [Transaction]()
    let realdb = RealmSwiftDB()
    let animationView = AnimationView()
    var app: UIApplication = UIApplication.shared
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatedTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            let defaults1 = UserDefaults.standard
            if response.notification.request.identifier == defaults1.string(forKey: "UNID") {
                let vc = self.storyboard?.instantiateViewController(identifier: "AllTransactions_VC") as! AllTransactions_ViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
                
                
                print("DONE333")
            }
            completionHandler()
            
        }
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
    
    
    func initViewsModifier() {
        
        notificationCenter.delegate = self
        
        let img = defaults.getProfileImage()
        
        if img != nil && img != ""{
            main_img.image = defaults.getProfileImage()?.toImage()
        }
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
    
    func getUpTrnCalculation() {

        // Current date
        let currentDate = Date()
        let calendar = Calendar.current

        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)


        //Calculation Stuff...
        var totalBalance_cal = Int(defaults.getCashBalance()!)
        var income_cal = Int(defaults.getIncome()!)
        var expense_cal = Int(defaults.getExpense()!)

        for singleT in transactionToShow {
            if singleT.isPresent == true {
                upcomingTrn.append(singleT)
            }
        }



        for trn in upcomingTrn {
            if trn.year == currentYear && trn.month == currentMonth && trn.day == currentDay {

                if trn.type == "Income ▼" || trn.type == "Kirim ▼" || trn.type == "수입 ▼" {
                    totalBalance_cal = totalBalance_cal! + Int(trn.amount)!
                    defaults.saveCashBalance(balance: String(totalBalance_cal!))
                    income_cal = income_cal! + Int(trn.amount)!
                    defaults.saveIncome(income: String(income_cal!))
                } else if trn.type == "Expense ▼" || trn.type == "Chiqim ▼" || trn.type == "경비 ▼" {
                    totalBalance_cal = totalBalance_cal! - Int(trn.amount)!
                    defaults.saveCashBalance(balance: String(totalBalance_cal!))
                    expense_cal = expense_cal! + Int(trn.amount)!
                    defaults.saveExpense(expense: String(expense_cal!))
                    defaults.saveIncome(income: String(income_cal!))
                }
                trn.isPresent = false
                realdb.deleteTransaction(object: trn)
                table_View.reloadData()
            }
        }

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
        openScreen(vc: "AllTransactions_VC")
    }
    
    
    @IBAction func info_IncomeBtn_Action(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InfoPopUp_VC") as! InfoPopUp_ViewController
        vc.isIncomeInfo = true
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func info_ExpenseBtn_Action(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InfoPopUp_VC") as! InfoPopUp_ViewController
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
    
    func openScreen(vc: String?) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc!)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
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
        // Current date
        let currentDate = Date()
        let calendar = Calendar.current

        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        
        let cell = Bundle.main.loadNibNamed("LastTransaction_TableViewCell", owner: self, options: nil)?.first as! LastTransaction_TableViewCell
        let lastTransaction = transactionToShow[indexPath.row]
        
        if lastTransaction.year == currentYear && lastTransaction.month == currentMonth && lastTransaction.day == currentDay {
            cell.upcoming_Label.isHidden = true
        }
        
        cell.actionDelegate = self
        cell.index = indexPath.row
        
        
        
        
        
        let icon = lastTransaction.icon
        cell.categoryImage.image = UIImage(systemName: icon)!
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Income ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyUS
        } else if lastTransaction.type == "경비 ▼" || lastTransaction.type == "수입 ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyKR
        } else if lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "Kirim ▼" {
            cell.amout.text = Int(lastTransaction.amount)?.currencyUZ
        }
        
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "경비 ▼" {
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        
        
        if lastTransaction.isPresent == false {
            cell.upcomingReminderView.isHidden = true
            cell.date.textColor = .lightGray
        } else if lastTransaction.isPresent == true {
            cell.upcomingReminderView.isHidden = false
            cell.date.textColor = .systemTeal
        }
        
        
        cell.notes.text = lastTransaction.notes
        cell.name.text = lastTransaction.category
        cell.date.text = lastTransaction.date
        
        
        return cell
    }
    
    func showUpTrn_AlertAction(body: String, object: Transaction) {
        let alert = UIAlertController(title: "Hi, Boss", message: body, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes I did", style: .default, handler: { [self] action in
            getUpTrnCalculation()
            openScreen(vc: "Home_VC")
        }))
        alert.addAction(UIAlertAction(title: "Not and Delete", style: .cancel, handler: { [self] action in
            realdb.deleteTransaction(object: object)
            openScreen(vc: "Home_VC")
        }))
    }
    
    func didButtonTapped(index: Int) {
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lastTransaction = transactionToShow [indexPath.row]
        
        
        if lastTransaction.isPresent == true {
            let vc = self.storyboard?.instantiateViewController(identifier: "CheckingUpcomingTrn_VC") as! CheckingUpcomingTrn_ViewController

            vc.selectedTransaction = lastTransaction
            
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "SelectedTransaction_VC") as! SelectedTransaction_ViewController

            vc.selectedTransacion = lastTransaction
            vc.amount = lastTransaction.amount
            vc.categoryImg = lastTransaction.icon
            vc.category_Label = lastTransaction.category
            vc.type = lastTransaction.type
            vc.date = lastTransaction.date
            vc.note = lastTransaction.notes
            
            vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
        }
        
            
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    

        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let lastTransaction = self.transactionToShow[indexPath.row]
        
//        func removeSelectedUserNotification() {
//            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
//               var identifiers: [String] = []
//               for notification:UNNotificationRequest in notificationRequests {
//                if notification.identifier == lastTransaction.uuid {
//                      identifiers.append(notification.identifier)
//                   }
//               }
//               UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
//            }
//        }
        
        let expenseL = "expenseL".localized()
        let incomeL = "incomeL".localized()
        
        var totalBalance = Int(defaults.getCashBalance()!)
        var income = Int(defaults.getIncome()!)
        var expense = Int(defaults.getExpense()!)
        
        func showActionSheet() {
            
            let actionsheet = UIAlertController(title: "Would you like to delete this transaction?", message: nil, preferredStyle: .actionSheet)
            
            actionsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
                
                if lastTransaction.isPresent != true {
                    if lastTransaction.type == (expenseL + " ▼") {
                        totalBalance = totalBalance! + Int(lastTransaction.amount)!
                        self.defaults.saveCashBalance(balance: String(totalBalance!))
                        if expense! >= 0 {
                            expense = expense! - Int(lastTransaction.amount)!
                            self.defaults.saveExpense(expense: String(expense!))
                        }
                    } else if lastTransaction.type == (incomeL + " ▼") {
                        totalBalance = totalBalance! - Int(lastTransaction.amount)!
                        self.defaults.saveCashBalance(balance: String(totalBalance!))
                        if income! >= 0 {
                            income = income! - Int(lastTransaction.amount)!
                            self.defaults.saveIncome(income: String(income!))
                        }
                    }
                }
                
                notificationCenter.removeDeliveredNotifications(withIdentifiers: [lastTransaction.uuid])
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [lastTransaction.uuid])
                
                self.realdb.deleteTransaction(object: lastTransaction)
                self.transactionToShow = self.realdb.getTransactions()
                self.table_View.reloadData()
                openScreen(vc: "Home_VC")
                
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
    
    public func animatedTableView() {
        table_View.reloadData()
        let cells = table_View.visibleCells
        let tableViewHeight = table_View.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
        
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

