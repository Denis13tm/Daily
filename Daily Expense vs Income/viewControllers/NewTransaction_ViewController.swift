//
//  NewTransaction_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 02/11/2021.
//
import UserNotifications
import UIKit

class NewTransaction_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UNUserNotificationCenterDelegate {

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
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var type_label: UILabel!
    @IBOutlet var amount_label: UILabel!
    @IBOutlet var category_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var notes_label: UILabel!
    @IBOutlet var saveBtn: UIButton!
    
    
    
    var title5 = "title5".localized()
    var type = "type".localized()
    var typeLabel = "typeLabel".localized()
    var expenseL = "expenseL".localized()
    var incomeL = "incomeL".localized()
    var amount = "amount".localized()
    var category_ = "category".localized()
    var categorylabel = "categoryLabel".localized()
    var date = "date".localized()
    var setDate = "setDate".localized()
    var notes = "notes".localized()
    var notePlaceholder = "notePlaceholder".localized()
    var errorLabel = "error".localized()
    var saveBtn_label = "saveBtn".localized()
    
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let realmDB = RealmSwiftDB()
    let notificationCenter = UNUserNotificationCenter.current()
    let publishNotification = NotificationPublisher()
    var transactionToShow = [Transaction]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in }
        notificationCenter.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        initViews()
        overrideUserInterfaceStyle = .light

    }
    
    
    //MARK: - Methods...
    
    func initViews() {
    
        
        setLangValue()
        
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
    
    
    func setLangValue() {
        
        title_label.text = title5
        type_label.text = type
        typeSelectorIndicator.text = typeLabel
        expenseSelectLabel.text = expenseL
        incomeSelectLabel.text = incomeL
        amount_label.text = amount
        category_label.text = category_
        categoryLabel.setTitle(categorylabel, for: .normal)
        date_label.text = date
        dateInputLabel.text = setDate
        notes_label.text = notes
        notesLabel.placeholder = notePlaceholder
        warningLabel.text = errorLabel
        saveBtn.setTitle(saveBtn_label, for: .normal)
        
    }

    
    @IBAction func datePicker_Action(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateInputLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        print(datePicker.date)
        
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

        newTransaction.amount = amount
        newTransaction.icon = defaults1.string(forKey: "categoryIcon")!
        newTransaction.type = type
        newTransaction.category = defaults1.string(forKey: "categoryTitle")!
        newTransaction.date = date
        newTransaction.notes = notes
        
        
        //Calculation Stuff...

        var totalBalance = Int(defaults.getCashBalance()!)
        var income = Int(defaults.getIncome()!)
        var expense = Int(defaults.getExpense()!)
        
        // Current date
        let currentDate = Date()
        let calendar = Calendar.current
                
        let currentYear = calendar.component(.year, from: currentDate) //year: Int
        let currentMonth = calendar.component(.month, from: currentDate) //month: Int
        let currentDay = calendar.component(.day, from: currentDate) //day: Int
        let currentHour = calendar.component(.hour, from: currentDate) //day: Int
        let currentMinute = calendar.component(.minute, from: currentDate) //day: Int
        
        
        // DatePicker orqali tanlangan date
        let yearFromDatePicker = calendar.component(.year, from: datePicker.date) //year: Int
        let monthFromDatePicker = calendar.component(.month, from: datePicker.date) //month: Int
        let dayFromDatePicker = calendar.component(.day, from: datePicker.date) //day: Int
        let hourFromDatePicker = calendar.component(.hour, from: datePicker.date) //day: Int
        let minuteFromDatePicker = calendar.component(.minute, from: datePicker.date) //day: Int
        
        newTransaction.year = yearFromDatePicker
        newTransaction.month = monthFromDatePicker
        newTransaction.day = dayFromDatePicker
        
        let uuidString = UUID().uuidString
        newTransaction.uuid = uuidString
        
        if currentYear == yearFromDatePicker {
            //if years equals, and then months sholud be compared
            if currentMonth == monthFromDatePicker {
                
                //if months equals, and then days be compared
                if currentDay == dayFromDatePicker {
                    if currentHour == hourFromDatePicker {
                        if currentMinute == minuteFromDatePicker {
                            if type == (expenseL + " ▼") {
                                totalBalance = totalBalance! - Int(amount)!
                                defaults.saveCashBalance(balance: String(totalBalance!))
                                expense = expense! + Int(amount)!
                                defaults.saveExpense(expense: String(expense!))
                                print("Expense")
                            } else if type == (incomeL + " ▼") {
                                totalBalance = totalBalance! + Int(amount)!
                                defaults.saveCashBalance(balance: String(totalBalance!))
                                income = income! + Int(amount)!
                                defaults.saveIncome(income: String(income!))
                                print("Income")
                            }
                            print("Now")
                        } else if currentMinute > minuteFromDatePicker {
                            if type == (expenseL + " ▼") {
                                totalBalance = totalBalance! - Int(amount)!
                                defaults.saveCashBalance(balance: String(totalBalance!))
                                expense = expense! + Int(amount)!
                                defaults.saveExpense(expense: String(expense!))
                                
                            } else if type == (incomeL + " ▼") {
                                totalBalance = totalBalance! + Int(amount)!
                                defaults.saveCashBalance(balance: String(totalBalance!))
                                income = income! + Int(amount)!
                                defaults.saveIncome(income: String(income!))
                                
                            }
                            print("Before minute")
                        } else if currentMinute < minuteFromDatePicker {
                            if type == (expenseL + " ▼") {
//                                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                                registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                            } else if type == (incomeL + " ▼") {
                                //                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                                registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                            }
                            newTransaction.isUpcoming = true
                            newTransaction.isPresent = true
                            print("After minute")
                        }
                    } else if currentHour > hourFromDatePicker {
                        if type == (expenseL + " ▼") {
                            totalBalance = totalBalance! - Int(amount)!
                            defaults.saveCashBalance(balance: String(totalBalance!))
                            expense = expense! + Int(amount)!
                            defaults.saveExpense(expense: String(expense!))
                            
                        } else if type == (incomeL + " ▼") {
                            totalBalance = totalBalance! + Int(amount)!
                            defaults.saveCashBalance(balance: String(totalBalance!))
                            income = income! + Int(amount)!
                            defaults.saveIncome(income: String(income!))
                            
                        }
                        print("Before hour")
                    } else if currentHour < hourFromDatePicker {
                        if type == (expenseL + " ▼") {
 //                           publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                            registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                        } else if type == (incomeL + " ▼") {
                            //                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                            registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                        }
                        newTransaction.isUpcoming = true
                        newTransaction.isPresent = true
                        print("After hour")
                    }
                    
                } else if currentDay > dayFromDatePicker {
                    // do
                    if type == (expenseL + " ▼") {
                        totalBalance = totalBalance! - Int(amount)!
                        defaults.saveCashBalance(balance: String(totalBalance!))
                        expense = expense! + Int(amount)!
                        defaults.saveExpense(expense: String(expense!))
                        
                    } else if type == (incomeL + " ▼") {
                        totalBalance = totalBalance! + Int(amount)!
                        defaults.saveCashBalance(balance: String(totalBalance!))
                        income = income! + Int(amount)!
                        defaults.saveIncome(income: String(income!))
                        
                    }
                    print("Before day")
                } else if currentDay < dayFromDatePicker {
                    if type == (expenseL + " ▼") {
//                        publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                        registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                    } else if type == (incomeL + " ▼") {
                        //                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                        registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                    }
                    newTransaction.isUpcoming = true
                    newTransaction.isPresent = true
                    print("After day")
                }
                
                
                //if month of datePicker less then current month
                // do...
            } else if currentMonth > monthFromDatePicker {
                // do
                if type == (expenseL + " ▼") {
                    totalBalance = totalBalance! - Int(amount)!
                    defaults.saveCashBalance(balance: String(totalBalance!))
                    expense = expense! + Int(amount)!
                    defaults.saveExpense(expense: String(expense!))
                    
                } else if type == (incomeL + " ▼") {
                    totalBalance = totalBalance! + Int(amount)!
                    defaults.saveCashBalance(balance: String(totalBalance!))
                    income = income! + Int(amount)!
                    defaults.saveIncome(income: String(income!))
                    
                }
                print("Before month")
            } else if currentMonth < monthFromDatePicker {
                //will do
                if type == (expenseL + " ▼") {
//                    publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                    registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                } else if type == (incomeL + " ▼") {
                    //                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                    registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
                }
                newTransaction.isUpcoming = true
                newTransaction.isPresent = true
                print("After month")
            }
            
            
            //if year of datePicker less then current year
            // do...
        } else if currentYear > yearFromDatePicker {
            //do
            if type == (expenseL + " ▼") {
                totalBalance = totalBalance! - Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                expense = expense! + Int(amount)!
                defaults.saveExpense(expense: String(expense!))
                
            } else if type == (incomeL + " ▼") {
                totalBalance = totalBalance! + Int(amount)!
                defaults.saveCashBalance(balance: String(totalBalance!))
                income = income! + Int(amount)!
                defaults.saveIncome(income: String(income!))
                
            }
            print("Before year")
        } else if currentYear < yearFromDatePicker {
            //will do
            if type == (expenseL + " ▼") {
//                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you spend that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
            } else if type == (incomeL + " ▼") {
//                publishNotification.send_N(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, useerN: notificationCenter)
                registerUserNotification(title: "Hi Boss, this's CASH FLOW", body: "Did you recieve that amount of money today?", badge: 1, hour: hourFromDatePicker, min: minuteFromDatePicker, uuid: newTransaction.uuid)
            }
            newTransaction.isUpcoming = true
            newTransaction.isPresent = true
            print("After year")
        }
        
        
        realmDB.saveTransaction(object: newTransaction)
        openScreen(vc: "Home_VC")
    }
        
    func getCurrentDate() -> Date{
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return currentDate
    }
    
    
    
    func showUpTrn_AlertAction(body: String, object: Transaction) {
        let alert = UIAlertController(title: "Hi, Boss", message: body, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.realmDB.deleteTransaction(object: object)
            self.openScreen(vc: "Home_VC")
        }))
        alert.addAction(UIAlertAction(title: "Not", style: .cancel, handler: { action in
            self.openScreen(vc: "Home_VC")
        }))
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "AllTransactions_VC")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
        
       print("Usernotification open screen")
        completionHandler()
    }

    
    
    func registerUserNotification(title: String, body: String, badge: Int?, hour: Int?, min: Int?, uuid: String) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = hour
        dateComponents.minute = min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        if let badge = badge {
            var currentBudgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBudgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBudgeCount)
        }
        
        notificationContent.sound = UNNotificationSound.default
        
        
        let uuidString = UUID().uuidString
        defaults1.set(uuidString, forKey: "UNID")
        
        let request = UNNotificationRequest(identifier: uuid, content: notificationContent, trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    

    
    func openScreen(vc: String?) {
        let vc = self.storyboard?.instantiateViewController(identifier: vc!)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    //Type of Transaction...
    
    var income = "income".localized()
    var expense = "expense".localized()
    
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
        typeSelectorIndicator.text = expense + " ▼"
        typeSelector_BV.isHidden.toggle()
    }

    func incomeTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.incomeSelected))
        self.incomeSelectLabel.isUserInteractionEnabled = true
        self.incomeSelectLabel.addGestureRecognizer(labelTap)
        

        }

    @objc func incomeSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorIndicator.text = income + " ▼"
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
