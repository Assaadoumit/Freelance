//
//  OTPVerifyViewController.swift
//  Free
//
//  Created by MacBookPro on 6/27/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class OTPVerifyViewController: UIViewController {
     @IBOutlet weak var verifyButton: UIButton!
     let userDefault = UserDefaults.standard
     @IBOutlet weak var codeTextField: UITextField!
     var isVerified : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verifyButton.layer.cornerRadius = 20
        codeTextField.layer.cornerRadius = 20
    }
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        
        if codeTextField.text?.isEmpty == true {
           print("Enter your verification code!")
           SVProgressHUD.showInfo(withStatus: "Enter the code received")
            return
        }else{

        SVProgressHUD.show()
        print("verify button pressed")
        guard let otpCode = codeTextField.text else {return}
        guard let verificationId = userDefault.string(forKey: "verificationID") else {return}

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
            Auth.auth().signInAndRetrieveData(with: credential) { (success, error) in
            if  error != nil {
                debugPrint("eroor is: \(error!.localizedDescription)")
                print("error verifiying")
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "Error Please try again")
            }else {

                debugPrint("Verified successfully")
                self.isVerified = true
                print("verified button should be hidden")
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
//                UserDefaults.standard.set(true, forKey: "isVerified")
                UserDefaults.standard.synchronize()
//                print("is Verified \(self.isVerified)")
//                try? Auth.auth().signOut()
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "ToAllIndustriesViewController", sender: self)
                }
            }
        }

    }
    

    @IBAction func ClosePopUpverify(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}
