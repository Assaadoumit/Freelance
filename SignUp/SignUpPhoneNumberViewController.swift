//
//  SignUpPhoneNumberViewController.swift
//  Free
//
//  Created by MacBookPro on 6/25/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpPhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var InsertCodeView: UIView!
    @IBOutlet weak var InsertPhoneView: UIView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var senButton: UIButton!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.layer.cornerRadius = 20
        InsertCodeView.isHidden = true
        InsertPhoneView.isHidden = false
        codeTextField.layer.cornerRadius = 20
        senButton.layer.cornerRadius = 20
        verifyButton.layer.cornerRadius = 20
     
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
        print("send button pressed")
         UserDefaults.init()
        
        self.InsertCodeView.isHidden = false
        let lebCountrycode = "+961"+phoneNumberTextField.text!
        var phoneNumber = lebCountrycode
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
        
                print(verificationID)
                guard let verifyId = verificationID else {return}
                self.userDefault.set(verifyId, forKey: "verificationID")
                self.userDefault.synchronize()
                
            }else{
                print("unable to get secret verification code from firebase  :\(error?.localizedDescription)")
            }
        }
      
    }
    @IBAction func verifyButtonPressed(_ sender: Any) {
        print("verify button pressed")
        guard let otpCode = codeTextField.text else {return}
        guard let verificationId = userDefault.string(forKey: "verificationID") else {return}
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
        Auth.auth().signInAndRetrieveData(with: credential) { (success, error) in
            if error == nil {
                print("success phone auth")
            }else{
                print("failes phone auth : \(error?.localizedDescription)")
            }
    }
    
    }

}
