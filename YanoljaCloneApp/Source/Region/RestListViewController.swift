//
//  RestListViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/14.
//

import Foundation
import UIKit

class RestListViewController : BaseViewController {
    
    lazy var dataManager : RegionDataManager = RegionDataManager()
    
    var SpecificLocation : String = ""
    var areaId : Int = 0
    
    var  hotelId : Array<String> = []
    
    var cellImg : Array<String> = []
    var cellLocation : Array<String> = []
    var cellTitle : Array<String> = []
    var cellRate : Array<String> = []
    
    var cellRentOriginalPrice : Array<String> = []
    var cellRentDiscountRate : Array<Int> = []
    var cellRentPrice : Array<String> = []
    var cellRentTimeUse : Array<String> = []
    
    var cellSleepDiscountRate : Array<Int> = []
    var cellSleepOriginalPrice : Array<String> = []
    var cellSleepPrice : Array<String> = []
    var cellSleepStart : Array<String> = []
    var cellEvent : Array<String> = []
    
    
    @IBOutlet weak var Location: UIView!
    @IBOutlet weak var LocationTitle: UILabel!
    @IBOutlet weak var Date: UIView!
    @IBOutlet weak var RestListTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Location.layer.borderWidth = 1
        Location.layer.borderColor = UIColor.darkGray.cgColor
        Date.layer.borderWidth = 1
        Date.layer.borderColor = UIColor.darkGray.cgColor
        
        dataManager.RequestRestList(days: "weekend", areadId: areaId, delegate: self)
        self.showIndicator()
        
        self.RestListTable.delegate = self
        self.RestListTable.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        Location.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let RVC = self.storyboard?.instantiateViewController(withIdentifier: "regionView") as! RegionViewController
        
        RVC.modalPresentationStyle = .overFullScreen
        RVC.modalTransitionStyle = .coverVertical
        RVC.closeCheck = false
        
        self.present(RVC, animated: true)
    }
}

extension RestListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = RestListTable.dequeueReusableCell(withIdentifier: "restCell", for: indexPath) as! RestListTableViewCell
        
        if let url = URL(string: cellImg[indexPath.row]) {
            let data =  try? Data(contentsOf: url)
            cell.cellImg.image = UIImage(data: data!)
        }
        
        cell.cellLocation.text = cellLocation[indexPath.row]
        cell.cellTitle.text = cellTitle[indexPath.row]
        cell.cellRate.text = cellRate[indexPath.row]
        
        cell.cellRentOriginalPrice.text = "\(cellRentOriginalPrice[indexPath.row])원"
        cell.cellRentDiscountRate.text = "\(cellRentDiscountRate[indexPath.row])~"
        cell.cellRentPrice.text = "\(cellRentPrice[indexPath.row])원"
        cell.cellRentTimeUse.text = cellRentTimeUse[indexPath.row]
        
        cell.cellSleepStart.text = "\(cellSleepStart[indexPath.row])부터"
        cell.cellSleepPrice.text = "\(cellSleepPrice[indexPath.row])원"
        cell.cellSleepDiscountRate.text = "\(cellSleepDiscountRate[indexPath.row])~"
        cell.cellSleepOriginalPrice.text = "\(cellSleepOriginalPrice[indexPath.row])원"
        cell.cellEvent.text = cellEvent[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextPhase = UIStoryboard(name: "SpecificRest", bundle: nil).instantiateViewController(withIdentifier: "specificRest") as! SpecificRestViewController
        
//        NextPhase.hotelId = self.hotelId[indexPath.row]
        self.navigationController?.pushViewController(NextPhase, animated: true)
    }

}
extension RestListViewController {
    
    func didRetrieveHotelList(result : RestListResponse){
        if result.isSuccess {
            
            for i in result.result.hotelList {
                
                self.hotelId.append(i.hotelId)
                
                self.cellImg.append(i.imgUrl)
                self.cellLocation.append(i.locationMemo)
                self.cellTitle.append(i.hotelName)
                if let rating = i.rating {
                    self.cellRate.append(rating)
                } else {
                    self.cellRate.append("5.0")
                }
                
                self.cellRentOriginalPrice.append(i.timePrice)
                self.cellRentDiscountRate.append(i.timePercent)
                if let rentTimeUse = i.timeUse {
                    self.cellRentTimeUse.append(rentTimeUse)
                } else{
                    self.cellRentTimeUse.append("5시간")
                }
                self.cellRentPrice.append(i.timeSale)
                
                self.cellSleepPrice.append(i.sleepSale)
                self.cellSleepOriginalPrice.append(i.sleepPrice)
                if let sleepStart = i.sleepStart {
                    self.cellSleepStart.append(sleepStart)
                } else {
                    self.cellSleepStart.append("22:00")
                }
                self.cellSleepDiscountRate.append(i.sleepPercent)
                self.cellEvent.append(i.event)
                
            }
            
            self.RestListTable.reloadData()
            self.dismissIndicator()
            
            
        } else {
            
            self.presentAlert(title: result.message)
            
        }
    }
    func failedToRequest(message : String){
        self.presentAlert(title: message)
    }
}
