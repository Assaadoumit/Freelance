//
//  SignUpPhoneNumberViewController.swift
//  Free
//
//  Created by MacBookPro on 6/25/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class SignUpPhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!

    @IBOutlet weak var InsertPhoneView: UIView!
   
   
    @IBOutlet weak var senButton: UIButton!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.layer.cornerRadius = 20
       
        InsertPhoneView.isHidden = false
        senButton.layer.cornerRadius = 20
        
     
    }
    
    
    @IBAction func ClosePopUp(_ sender: Any) {
         self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
            phoneNumberTextField.becomeFirstResponder()
        return true
    }
    
    
    
    @IBAction func sendPhoneNumber(_ sender: Any) {
        if phoneNumberTextField.text?.isEmpty ?? true {
            SVProgressHUD.showError(withStatus: "Enter a Valid Phone number")
        }else{
            SVProgressHUD.show()
        print("send button pressed")
         UserDefaults.init()
        
   
        let  lebCountrycode = "+961"+phoneNumberTextField.text!
            
        var phoneNumber = lebCountrycode
            SVProgressHUD.dismiss()
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                guard let verifyId = verificationID else {return}
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(lebCountrycode, forKey: "phoneNumber")
                
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "ToVerification", sender: self)
                print(" veerification ID is \(verificationID)")
                
                
            }else{
                print("unable to get secret verification code from firebase  :\(error?.localizedDescription)")
                
                SVProgressHUD.showError(withStatus: "Error Try Again")            }
            }
        }
      
    }
//    let verificationID: String? = nil
 

    
}

