//
//  AllIndustriesViewController.swift
//  Free
//
//  Created by MacBookPro on 6/25/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit

class AllIndustriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func acPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func builderPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func ptPessed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func haiPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func electricianPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func gardnerPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func masseusePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func painterPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func plumberPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func woodPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    }
    
    @IBAction func photographyPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "myPopupView", sender: self)
    
    }
    
}
