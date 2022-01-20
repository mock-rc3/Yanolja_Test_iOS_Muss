//
//  RestListViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/14.
//

import Foundation
import UIKit
import Alamofire

class RestListViewController : BaseViewController {
    
    lazy var dataManager : RegionDataManager = RegionDataManager()
    
    var SpecificLocation : String = ""
    var areaId : Int = 0
    
    var hotelId : Array<Int> = []
    
    var cellImg : Array<String> = []
    var cellLocation : Array<String> = []
    var cellTitle : Array<String> = []
    var cellRate : Array<String> = []
//    var cellReviewCount : Array<String> = []
    
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
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        Location.layer.borderWidth = 1
        Location.layer.borderColor = UIColor.darkGray.cgColor
        Date.layer.borderWidth = 1
        Date.layer.borderColor = UIColor.darkGray.cgColor
        
        
        LocationTitle.text = SpecificLocation
        
        //days -> weekend로 고정.
        dataManager.RequestRestList(days: "weekend", areadId: areaId, delegate: self)
        self.showIndicator()
        
        self.RestListTable.delegate = self
        self.RestListTable.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        Location.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let RVC = self.storyboard?.instantiateViewController(withIdentifier: "regionView") as! RegionViewController
        
        RVC.modalPresentationStyle = .overFullScreen
        RVC.modalTransitionStyle = .coverVertical
        
        self.present(RVC, animated: true)
    }
}

extension RestListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = RestListTable.dequeueReusableCell(withIdentifier: "restCell", for: indexPath) as! RestListTableViewCell
        
        //셀 클릭했을 때 회색으로 안변하게
        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background
        
        if let url = URL(string: cellImg[indexPath.row]) {
            let data =  try? Data(contentsOf: url)
            cell.cellImg.image = UIImage(data: data!)
        }
        
        cell.cellLocation.text = cellLocation[indexPath.row]
        cell.cellTitle.text = cellTitle[indexPath.row]
        cell.cellRate.rating = Double(cellRate[indexPath.row]) ?? 5.0
        cell.cellRate.text = cellRate[indexPath.row]
        
        cell.cellRentOriginalPrice.text = "\(cellRentOriginalPrice[indexPath.row])원"
        cell.cellRentDiscountRate.text = "\(cellRentDiscountRate[indexPath.row])%~"
        cell.cellRentPrice.text = "\(cellRentPrice[indexPath.row])"
        cell.cellRentTimeUse.text = "\(cellRentTimeUse[indexPath.row])시간"
        
        cell.cellSleepStart.text = "\(cellSleepStart[indexPath.row])부터"
        cell.cellSleepPrice.text = "\(cellSleepPrice[indexPath.row])"
        cell.cellSleepDiscountRate.text = "\(cellSleepDiscountRate[indexPath.row])%~"
        cell.cellSleepOriginalPrice.text = "\(cellSleepOriginalPrice[indexPath.row])원"
        cell.cellEvent.text = cellEvent[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 503
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let SRVC = UIStoryboard(name: "SpecificRest", bundle: nil).instantiateViewController(withIdentifier: "specificList") as! SpecificRestViewController
        
        SRVC.hotelId = self.hotelId[indexPath.row]
        
        self.navigationController?.pushViewController(SRVC, animated: true)
//        self.present(NextView, animated: true)
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
//                if let sumReview = i.sumReview {
//                    self.cellReviewCount.append(sumReview)
//                } else {
//                    self.cellReviewCount.append("145")
//                }
                
                if let timePrice = i.timePrice{
                    self.cellRentOriginalPrice.append(timePrice)
                } else{
                    self.cellRentOriginalPrice.append("30,000")
                }
                
                self.cellRentDiscountRate.append(i.timePercent)
                if let timeUse = i.timeUse {
                    self.cellRentTimeUse.append(timeUse)
                } else{
                    self.cellRentTimeUse.append("5")
                }
                
                if let timeSale = i.timeSale {
                    self.cellRentPrice.append(timeSale)
                } else{
                    self.cellRentPrice.append("10,000")
                }
                
                if let sleepSale = i.sleepSale {
                    self.cellSleepPrice.append(sleepSale)
                } else{
                    self.cellSleepPrice.append("30,000")
                }
                
                if let sleepPrice = i.sleepPrice{
                    self.cellSleepOriginalPrice.append(sleepPrice)
                }else{
                    self.cellSleepOriginalPrice.append("70,000")
                }
                
                if let sleepStart = i.sleepStart {
                    self.cellSleepStart.append(sleepStart)
                } else {
                    self.cellSleepStart.append("22:00")
                }
                self.cellSleepDiscountRate.append(i.sleepPercent)
                
                if let event = i.event{
                    self.cellEvent.append(event)
                } else{
                    self.cellEvent.append("엄청난 이벤트")
                }
                
                
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
