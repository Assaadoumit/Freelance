//
//  GalleryViewController.swift
//  Free
//
//  Created by MacBookPro on 8/5/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor.black
        
        images = [#imageLiteral(resourceName: "photography") , #imageLiteral(resourceName: "builder"), #imageLiteral(resourceName: "physical trainer"), #imageLiteral(resourceName: "physical trainer"), #imageLiteral(resourceName: "physical trainer")]

        for i in 0..<images.count {
            let imageView = UIImageView()
            let x = self.view.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            imageView.contentMode = .scaleAspectFit
             imageView.image = images[i]
            
            
            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
        
    }
    

    @IBAction func closeGallery(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }

}
