//
//  MyProfileViewController.swift
//  Free
//
//  Created by MacBookPro on 6/26/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import CDAlertView

class MyProfileViewController: UIViewController {
    
    
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var finalName : String = ""
    var finalEmail : String = ""
    var guest = SignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(name: nameLabel, email: emailLabel)
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        logOut.layer.cornerRadius = 20
        if guest.isGuest == false{
             logOut.isHidden = true
        }
        
//        if guest.isGuest != false {
//            //pop up sign in to continue
//            print("guest entering myProfile")
//            print(guest.isGuest)
//
//            let alert = CDAlertView(title: "you're not Logged In", message: "Please //  LogIn to continue", type: .notification)
////            let doneAction = CDAlertViewAction(title: "Sure")
////            alert.add(action: doneAction)
//            let nevermindAction = CDAlertViewAction(title: "ok")
//            alert.add(action: nevermindAction)
//            alert.show()
//        }else {
//            print("not guest")
//        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        fetchData(name: nameLabel, email: emailLabel)
//        fetchImage(profileImage: profileImage)
        if guest.isGuest == false {
            //pop up sign in to continue
            print("guest entering myProfile")
            print(guest.isGuest)
            let alert = CDAlertView(title: "you're not Logged In", message: "Please LogIn to continue", type: .notification)
//            let doneAction = CDAlertViewAction(title: "Sure!")
//            alert.add(action: doneAction)
            let nevermindAction = CDAlertViewAction(title: "ok ")
            alert.add(action: nevermindAction)
            alert.show()
        }else {
            print("not guest")
        }
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
            SVProgressHUD.show()
            let userDefault = UserDefaults.init()
        SVProgressHUD.dismiss()
            let alertController = UIAlertController(title: "Logging Out", message: "Are you sure you want to log out", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            do{
                SVProgressHUD.dismiss()
                try Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.navigationController?.popToRootViewController(animated: true)
                self.performSegue(withIdentifier: "SigningOut", sender: self)
                print("signed out")
                
            }catch{
                SVProgressHUD.dismiss()
                print("error signing out")
                SVProgressHUD.showError(withStatus: "Error signing out")
                self.performSegue(withIdentifier: "SigningOut", sender: self)
                print("signed out")
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            SVProgressHUD.dismiss()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

       
    }
    func fetchData(name: UILabel, email:UILabel){
        let UserDefault = UserDefaults.init()
        let email = UserDefault.string(forKey: "email")
        let name = UserDefault.string(forKey: "name")
        nameLabel.text = name
        emailLabel.text = email
        UserDefault.synchronize()
        
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
         if guest.isGuest == false {
            let alert = CDAlertView(title: "you're not Logged In", message: "Please LogIn to continue", type: .notification)
            //            let doneAction = CDAlertViewAction(title: "Sure!")
            //            alert.add(action: doneAction)
            let nevermindAction = CDAlertViewAction(title: "ok ")
            alert.add(action: nevermindAction)
            alert.show()
    
         }else{
            self.performSegue(withIdentifier: "editProfile", sender: self)
            print("edit profile pressed")
        }
            
    }
    //    func fetchImage(profileImage : UIImageView){
//        
//          let UserDefault = UserDefaults.init()
//        let profileImageUpdated = UserDefaults.value(forKey: "profileImage")
//        if profileImageUpdated == nil{
//         profileImage.image = #imageLiteral(resourceName: "Image")
//        }else{
//            profileImage.image = (profileImageUpdated as!  UIImage)
//        }
//    }
//    
    
}
