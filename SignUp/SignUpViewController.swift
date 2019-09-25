//
//  SignUpViewController.swift
//  Free
//  Created by MacBookPro on 6/21/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class SignUpViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var signUpPopUp: UIView!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var signUpButtonInside: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var asGuestPressed: UIButton!
    var isGuest : Bool!
    
    
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
    
    @IBAction func continueAsAGuest(_ sender: Any) {
        SVProgressHUD.show()
        isGuest = true
        print(isGuest)
        self.performSegue(withIdentifier: "AllIndustriesViewController", sender: self)
        print("continue as a guest pressed")
        SVProgressHUD.dismiss()
    }
    
    
    
    @IBAction func signUpButtonInsidePressed(_ sender: Any) {
        let userDefault = UserDefaults.init()
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
                let alertController = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
    
                
                let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                SVProgressHUD.dismiss()
                print("Registration Successful!")
                self.performSegue(withIdentifier: "AllIndustriesViewController", sender: self)
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
            }
        }
        
        
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
        let accessToken = AccessToken.current
        if asGuestPressed.isTouchInside == true {
            isGuest = true
        }else{
            isGuest = false
        }
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
    
    @IBAction func signupWithFacebook(_ sender: Any) {
        print("signe in with facebook pressed")
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: _):
                self.signIntoFirebase()
                print("success logging with facebook")
                
            case .failed(let error):
                print(error)
            case .cancelled:
                print("canceled")
            }
        }
        
    }
    
    func getUserDetails(){
        
        if(AccessToken.current != nil){
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id,name , first_name, last_name , email"]).start(completionHandler: { (connection, result, error) in
                
                guard let Info = result as? [String: Any] else { return }
                
                if let userName = Info["name"] as? String
                {
                    print(userName)
                }
                
            })
        }
    }
   
   
   
    func signIntoFirebase() {
        guard   let authenticationToken = AccessToken.current else{return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: "\(authenticationToken)")
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error{
                print("error of sign into firebase is \(error)")
                return
            }else{
                print("Success logged in to facebook")
            }
        }
    }
    
 

}
