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
    @IBOutlet var home_btn: UIView!
    @IBOutlet var home_bnt_BImg: UIImageView!
    
    @IBOutlet var main_img: UIImageView!
    
    @IBOutlet var totalMoney_view: UIImageView!
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var baseCurrency: UILabel!
    
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
    
    @IBOutlet var bottomSide_View: UIView!
    
    @IBOutlet var noTransactionsView: UIView!
    @IBOutlet var table_View: UITableView!
    
    @IBOutlet var bottomSidesItemView: UIView!
    
    @IBOutlet var rightBtnBackgroundView: UIView!
    @IBOutlet var centerBtnBackgroundView: UIView!
    @IBOutlet var leftBtnBackgroundView: UIView!
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    
    var transactionToShow = [Transaction]()
    let realdb = RealmSwiftDB()
    let animationView = AnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMethods()

    }
    
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
    
    
    //MARK: - Methods
    
    func initMethods() {
        
        initViewsModifier()
        registerForNotification()
        setupAnimation()
    }
    
    func registerForNotification() {
        
        // Notification content.
        let content = UNMutableNotificationContent()
        content.title = "Hi "
        content.body = "Did you check your cash balance today"
        
        //Date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 23
        dateComponents.minute = 24
        
        
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
        
        transactionToShow = realdb.getTransactions()
        
        
        modifierUI(ui: navigationBarBackgroundView)
        home_bnt_BImg.layer.cornerRadius = 11.0
        main_img.layer.cornerRadius = 22.0


        totalMoney_view.layer.cornerRadius = 22.0
        
        totalBalance.text = defaults.getCashBalance()
        baseCurrency.text = defaults.getCurrency()

        
        totalMoney_background.layer.cornerRadius = 22.0
        modifierUI(ui: totalMoney_background)

        add.layer.cornerRadius = 27.5


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
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("taking-notes")
        animationView.frame = noTransactionsView.bounds
        animationView.backgroundColor = #colorLiteral(red: 0.9213312575, green: 0.9213312575, blue: 0.9213312575, alpha: 1)
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
        } else {
            table_View.isHidden = false
            noTransactionsView.isHidden = true
            setupAnimation()
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
        cell.amout.text = lastTransaction.amount
        if lastTransaction.type == "Expense ▼"{
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        cell.notes.text = lastTransaction.notes
        cell.name.text = lastTransaction.category
        cell.date.text = lastTransaction.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let lastTransaction = allTransactions[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(identifier: "AllTransactions_ VC")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)


    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let lastTransaction = transactionToShow[indexPath.row]
            realdb.deleteTransaction(object: lastTransaction)
            transactionToShow = realdb.getTransactions()
            table_View.reloadData()
        }
        
    }
    

    

 


}
