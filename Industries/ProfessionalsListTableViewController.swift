//
//  ProfessionalsListTableViewController.swift
//  Free
//
//  Created by MacBookPro on 6/27/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit

struct cellData {
    
    
    let cell : Int
    let name : String
    let area : String
    let profImage : UIImage
    
}
class ProfessionalsListTableViewController: UITableViewController {
 
    var arrayOfCellData = [cellData]()
    
 
    @IBAction func backButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfCellData = [cellData(cell: 1, name: "Photgraphers", area: "Beirut", profImage: #imageLiteral(resourceName: "photography")),
                           cellData(cell: 2, name: "Abdel karim", area: "North", profImage:#imageLiteral(resourceName: "icons8-facebook-filled-50") ),
                           cellData(cell: 2, name: "Abou Ali", area: "South", profImage: #imageLiteral(resourceName: "iconfinder_Flag_of_Lebanon_96231")),
                           cellData(cell: 2, name: "Nouh Zeiter", area: "Bekaa", profImage: #imageLiteral(resourceName: "iconfinder_Flag_of_Lebanon_96231")),
                           cellData(cell: 2, name: "Abou Salle", area: "Maten", profImage: #imageLiteral(resourceName: "iconfinder_Flag_of_Lebanon_96231")),
                           cellData(cell: 2, name: "Farid Khazen", area: "Fanar", profImage: #imageLiteral(resourceName: "iconfinder_Flag_of_Lebanon_96231"))]
        
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrayOfCellData[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("TableViewCell1TableViewCell", owner: self, options: nil)?.first as! TableViewCell1TableViewCell
            
            cell.pageImage.image = arrayOfCellData[indexPath.row].profImage
            cell.pageTitle.text = arrayOfCellData[indexPath.row].name
            
            return cell
            
        }else if arrayOfCellData[indexPath.row].cell == 2{
            
            let cell = Bundle.main.loadNibNamed("TableViewCell2", owner: self, options: nil)?.first as! TableViewCell2
            
            cell.mainImageView.image = arrayOfCellData[indexPath.row].profImage
            cell.mailLabel.text = arrayOfCellData[indexPath.row].name
            cell.area.text = arrayOfCellData[indexPath.row].area
            
            return cell
            
        }else{
            let cell = Bundle.main.loadNibNamed("TableViewCell1TableViewCell", owner: self, options: nil)?.first as! TableViewCell1TableViewCell
            
            cell.pageImage.image = arrayOfCellData[indexPath.row].profImage
            cell.pageTitle.text = arrayOfCellData[indexPath.row].name
            
            return cell
            
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1{
            return 244
        }else if arrayOfCellData[indexPath.row].cell == 2{
            return 100
        }else{
            return 244
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected is :\(indexPath.row)")
        self.performSegue(withIdentifier: "profProfile", sender: self)
    }
 

}
