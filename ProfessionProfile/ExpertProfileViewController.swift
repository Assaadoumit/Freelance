//  ExpertProfileViewController.swift
//  Free
//  Created by MacBookPro on 6/26/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit

struct scrollViewDataStruct {
    let Title : String?
    let imgae : UIImage?
}
class ExpertProfileViewController: UIViewController , UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var call: UIButton!
    var numberToDial : String = "71565580"
    var scrollViewData = [scrollViewDataStruct]()
    var viewTagValue = 10
    var tagValue = 100
    override func viewDidLoad() {
        
//        let darkBlur = UIBlurEffect(style: .dark)
//        let blurView = UIVisualEffectView(effect: darkBlur)
//        blurView.frame = backgroundImage.bounds
//        backgroundImage.addSubview(blurView)
        
        call.setTitle(numberToDial, for: .normal)
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        scrollView.delegate = self
        
        scrollViewData = [scrollViewDataStruct.init(Title: "", imgae: #imageLiteral(resourceName: "builder")),
                          scrollViewDataStruct.init(Title: "", imgae: #imageLiteral(resourceName: "physical trainer")),
                          scrollViewDataStruct.init(Title: "", imgae: #imageLiteral(resourceName: "profileBackground")),
                          scrollViewDataStruct.init(Title: "", imgae: #imageLiteral(resourceName: "makeup"))]
        
        scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(scrollViewData.count)
        var i = 0
        for data  in scrollViewData {
            let view = CustomView (frame: CGRect(x: 10+(self.scrollView.frame.width * CGFloat(i)), y: 80, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height - 90))
            view.imageView.image = data.imgae
            view.tag = i + viewTagValue
            self.scrollView.addSubview(view)
            
            let label = UILabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 20), size: CGSize.init(width: 0, height: 1)))
            label.text = data.Title
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = UIColor.black
            label.sizeToFit()
            label.tag = i + tagValue
            if i == 0{
                label.center.x = view.center.x
            }else{
                label.center.x = view.center.x - self.scrollView.frame.width / 2
            }
            self.scrollView.addSubview(label)
            //to Stay at the buttom
            i += 1
        }
    
    }
    @IBAction func callMe(_ sender: Any) {
        dialNumber(number: numberToDial)
    }
    
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    func blurImage(usingImage image : UIImage, blurAmount: CGFloat) -> UIImage?{
        guard let ciImage = CIImage(image: image) else
        {
            return nil
        }
        let blurFilter = CIFilter(name: "CIImageBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else
        {
            return nil
        }
        return UIImage(ciImage: outputImage)
    }
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    @IBAction func viewMoreImages(_ sender: Any) {
     self.performSegue(withIdentifier: "toGallery", sender: self)
    }
    
}
class CustomView: UIView{
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


