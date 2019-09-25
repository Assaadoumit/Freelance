//
//  EditProfileViewController.swift
//  Free
//
//  Created by MacBookPro on 6/28/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseStorage
import Firebase

class EditProfileViewController: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    var nameText = ""
    @IBOutlet weak var editImageView: UIImageView!
    var emailText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let isVerified:Bool = UserDefaults.standard.bool(forKey: "isVerified")
        let userSignedIn = Auth.auth().currentUser
        
        // to retrieve user info from firebase and show it on app profile page
        
        if  (isVerified == true){
        verifyButton.isHidden = true
            print("verified button is hidden")
        }else{
            
        }
        emailTextField.delegate = self
        nameTextField.delegate = self
        emailTextField.returnKeyType = .done
        nameTextField.returnKeyType = .next
        verifyButton.layer.cornerRadius = 20
        editImageView.layer.cornerRadius = editImageView.frame.height / 2
        editImageView.clipsToBounds = true

        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("next button pressed")
        if (textField === nameTextField)
        {
            nameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        }else{
            emailTextField.resignFirstResponder()
            self.view.endEditing(true)
        }
        
        return true
    }
    
    

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        print("back button pressed")
    }
    
        
    @IBAction func verifyPhoneNumber(_ sender: Any) {
        
    
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        let UserDefault = UserDefaults.init()
        self.nameText  = nameTextField.text!
        self.emailText = emailTextField.text!
        
        UserDefault.set(emailTextField.text, forKey: "email")
        UserDefault.synchronize()
        UserDefault.set(nameTextField.text, forKey: "name")
        
        print("save button pressed")
//        UserDefault.setValue(editImageView, forKey: "profileImage")
//        UserDefault.synchronize()
//       
//    
    }

    @IBAction func changeImage(_ sender: Any){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    
    
   
    }
    func hideVerifyButton()-> Bool{
        verifyButton.isHidden = true
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            editImageView.image = image
            
        }
        dismiss(animated: true, completion: nil)
      
    }
    


}


