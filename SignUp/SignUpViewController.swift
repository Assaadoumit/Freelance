//
//  SignUpViewController.swift
//  Free
//
//  Created by MacBookPro on 6/21/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var signUpPopUp: UIView!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var signUpButtonInside: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBAction func SignUpWithPhoneNumber(_ sender: Any) {
        signUpPopUp.isHidden = true
        self.shouldPerformSegue(withIdentifier: "SignUpPhoneNumber", sender: self)
        print("signup with phone number pressed")
    }
    
    @IBAction func logInButtonOutsidePressed(_ sender: Any) {
        self.shouldPerformSegue(withIdentifier: "LogIn", sender: self)
        print("login pressed")
        
    }
    
    @IBAction func closeSignUpPopUp(_ sender: Any) {
        signUpPopUp.isHidden = true
         self.view.endEditing(true)
        
    }
    
    
    @IBAction func SignUpButtonPressed(_ sender: Any) {
        signUpPopUp.isHidden = false
        print("sign up button pressed")
    }
    
  
    @IBAction func signUpButtonInsidePressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                let alertController = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
    
                
                let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("Registration Successful!")
            }
        }
        
        2
        self.view.endEditing(true)
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpPopUp.isHidden = true
        SignUpButton.layer.cornerRadius = 20
        signUpButtonInside.layer.cornerRadius = 20
        emailTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
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
    
    

}
