//
//  LogInViewController.swift
//  Free
//
//  Created by MacBookPro on 6/25/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var logIn: UIButton!
    
    @IBAction func closeLogInPopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
         self.view.endEditing(true)
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("next button pressed")
        if (textField === emailTextField)
        {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }else{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    

    @IBAction func LogInPressed(_ sender: Any) {
    
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                let alertController = UIAlertController(title: "Error", message: "Invalid Account", preferredStyle: .alert)
                
                
                let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    print("Cancel Pressed")
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
//                SVProgressHUD.showInfo(withStatus: "error logging in")
//                SVProgressHUD.dismiss()
                
            } else {
                print("Log in successful!")
                 self.view.endEditing(true)
            
//                SVProgressHUD.dismiss()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        emailTextField.delegate = self
        passwordTextField.delegate = self
        logIn.layer.cornerRadius = 20
    }
    
}
