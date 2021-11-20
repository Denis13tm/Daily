//
//  OtpVC.swift
//  Cash Flow
//
//  Created by Odiljon Ergashev on 2021/11/09.
//

//import UIKit
//
//class OtpVC: UIViewController {
//    
//    @IBOutlet weak var firstDotImage: UIImageView!
//    @IBOutlet weak var secondDotImage: UIImageView!
//    @IBOutlet weak var thirdDotImage: UIImageView!
//    @IBOutlet weak var fourthDotImage: UIImageView!
//    @IBOutlet weak var fifthDotImage: UIImageView!
//    @IBOutlet weak var sixthDotImage: UIImageView!
//    @IBOutlet weak var errorLabel: UILabel!
//    let userDefaults = DefaultsOfUser()
//    var password = [String]()
//    var OTP = ""
//   
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBAction func enterPasswordAction(_ sender: UIButton) {
//        setDotImages(number: sender.currentTitle!)
//    }
//    
//    
//    public func setDotImages(number: String){
//        switch password.count {
//        case 0:
//            password.append(number)
//            firstDotImage.image = #imageLiteral(resourceName: "otp_selected_dot")
//        case 1:
//            password.append(number)
//            secondDotImage.image = #imageLiteral(resourceName: "otp_selected_dot")
//        case 2:
//            password.append(number)
//            thirdDotImage.image = #imageLiteral(resourceName: "otp_selected_dot")
//        case 3:
//            password.append(number)
//            fourthDotImage.image = #imageLiteral(resourceName: "otp_selected_dot")
//        case 4:
//            password.append(number)
//            fifthDotImage.image = #imageLiteral(resourceName: "otp_selected_dot")
//        case 5:
//            password.append(number)
//            sixthDotImage.image = #imageLiteral(resourceName: "otp_selected_dot")
//            
//            if password.joined(separator: "") == userDefaults.getPassword() {
//                let dialogVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as? MainVC
//                dialogVC?.modalPresentationStyle = .overCurrentContext
//                dialogVC?.modalTransitionStyle = .crossDissolve
//                self.present(dialogVC!, animated: false, completion: nil)
//            } else {
//                errorLabel.text = "Password incorrect"
//                firstDotImage.image = #imageLiteral(resourceName: "otp_unselected")
//                secondDotImage.image = #imageLiteral(resourceName: "otp_unselected")
//                thirdDotImage.image = #imageLiteral(resourceName: "otp_unselected")
//                fourthDotImage.image = #imageLiteral(resourceName: "otp_unselected")
//                fifthDotImage.image = #imageLiteral(resourceName: "otp_unselected")
//                sixthDotImage.image = #imageLiteral(resourceName: "otp_unselected")
//                password.removeAll()
//            }
//       
//        default:
//            errorLabel.text = "Something is wrong))"
//        }
//    }
//
//}


//func setUp_texField() {
//    
//    self.tf1.delegate = self
//    self.tf2.delegate = self
//    self.tf3.delegate = self
//    self.tf4.delegate = self
//    
//    self.tf1.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
//    self.tf2.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
//    self.tf3.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
//    self.tf4.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
//    
//}
//
//
//@objc func changeCharacter(textField: UITextField) {
//    var matchingKey: String?
//    
//    if textField.text?.utf8.count == 1 {
//        switch textField {
//        case tf1:
//            tf2.becomeFirstResponder()
//            tf1.isHidden = true
//            dotView1.backgroundColor = .white
//        case tf2:
//            tf3.becomeFirstResponder()
//            tf2.isHidden = true
//            dotView2.backgroundColor = .white
//        case tf3:
//            tf4.becomeFirstResponder()
//            tf3.isHidden = true
//            dotView3.backgroundColor = .white
//        case tf4:
//            tf4.isHidden = true
//            dotView4.backgroundColor = .white
//            matchingKey = tf1.text! + tf2.text! + tf3.text! + tf4.text!
//            if defaults.getPasscode() == matchingKey {
//                openScreen(vc: "Home_VC")
//            } else {
//                warningLabel.isHidden = false
//            }
//            print("OTP = \(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)")
//        default:
//            break
//        }
//    } else if textField.text!.isEmpty {
//        switch textField {
//        case tf4:
//            tf3.becomeFirstResponder()
//            dotView4.backgroundColor = .clear
//            tf4.isHidden = false
//        case tf3:
//            tf2.becomeFirstResponder()
//            dotView3.backgroundColor = .clear
//            tf3.isHidden = false
//        case tf2:
//            tf1.becomeFirstResponder()
//            dotView2.backgroundColor = .clear
//            tf2.isHidden = false
//        case tf1:
//            dotView1.backgroundColor = .clear
//            tf1.isHidden = false
//        default:
//            break
//        }
//    }
//    
//}
