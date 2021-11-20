//
//  Profile_ViewController.swift
//  Daily Expense vs Income
//
//  Created by Otabek Tuychiev on 10/11/2021.
//

import UIKit

class Profile_ViewController: UIViewController {

    
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var incomeVsExpense_BV: UIView!
    @IBOutlet var expense_BV: UIView!
    @IBOutlet var income_BV: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()

    
    }
    
    
    //MARK: - Methods...
    
    func initViews() {
        expense_BV.layer.cornerRadius = 18.0
        modifierUI(ui: incomeVsExpense_BV)
        
        income_BV.layer.cornerRadius = 18.0
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5
    }

    @IBAction func imagePickerBtn_Action(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}


extension Profile_ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
