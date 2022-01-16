//
//  specificRestViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/15.
//

import Foundation
import UIKit

class SpecificRestViewController : BaseViewController {
    
    lazy var dataManager : SpecificDataManager = SpecificDataManager()
    var hotelId : Int = 0
    
    var roomName : Array<String> = []
    var roomMemo : Array<String> = []
    var minPersonnel : Array<String> = []
    var maxPersonnel : Array<String> = []
    var timePercent : Array<String> = []
    var timeUse : Array<String> = []
    var timePrice : Array<String> = []
    var timeSale : Array<String> = []
    var sleepCheckin : Array<String> = []
    var sleepPercent : Array<String> = []
    var sleepPrice : Array<String> = []
    var sleepSale : Array<String> = []
    
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var HotelTitle: UILabel!
    @IBOutlet weak var HotelRate: UILabel!
    @IBOutlet weak var locationMemo: UILabel!
    @IBOutlet weak var restListTableView: UITableView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var LargeText1: UILabel!
    @IBOutlet weak var smallText1: UILabel!
    @IBOutlet weak var LargeText2: UILabel!
    @IBOutlet weak var smallText2: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.requestSpecificRestList(startDate: "2022-01-09", endDate: "2022-01-10", days: "weekend", hotelId: 1, delegate: self)
        self.showIndicator()
        
        view1.layer.addBorder([.top, .bottom, .left, .right], color: UIColor.emailBlue, width: 1)
        view1.layer.cornerRadius = 30
        
        view2.layer.addBorder([.top, .bottom], color: UIColor.lightGray, width: 0.5)
        
        view3.layer.addBorder([.top, .bottom], color: UIColor.lightGray, width: 0.5)
        
        view4.layer.addBorder([.bottom], color: UIColor.lightGray, width: 0.5)
        
        self.restListTableView.delegate = self
        self.restListTableView.dataSource = self
        
    }
}

extension SpecificRestViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = restListTableView.dequeueReusableCell(withIdentifier: "restSpecificCell", for: indexPath) as! RestTableViewCell
        
        cell.roomName.text = roomName[indexPath.row]
        cell.roomMemo.text = roomMemo[indexPath.row]
        cell.Personnel.text = "기준 \(minPersonnel[indexPath.row])명 / 최대 \(maxPersonnel[indexPath.row])명"
        cell.timeUse.text = "최대 \(timeUse[indexPath.row])시간"
//        cell.timePercent.text = "\(timePercent[indexPath.row])%"
        cell.timePrice.text = "\(timePrice[indexPath.row])원"
        cell.timeSale.text = "\(timeSale[indexPath.row])원"
//        cell.sleepCheckin.text = "\(sleepCheckin[indexPath.row][0...1]):\(sleepCheckin.text[indexPath.row][2...3])부터"
//        cell.sleepPercent.text = "\(sleepPercent[indexPath.row])%"
        cell.sleepSale.text = "\(sleepSale[indexPath.row])원"
        cell.sleepPrice.text = "\(sleepPrice[indexPath.row])원"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        return 0
//    }
}

extension SpecificRestViewController {
    
    func didRetrieveRestList(result: SpecificResponse){
        if result.isSuccess {
            
            if let url = URL(string: result.result.hotelImg[0]){
                let data = try? Data(contentsOf: url)
                mainImg.image = UIImage(data: data!)
            }
            HotelTitle.text = result.result.hotelInfo.hotelName
            HotelRate.text = result.result.hotelInfo.rating
            locationMemo.text = result.result.hotelInfo.locationMemo
            
            for i in result.result.roomList {
                roomName.append(i.roomName)
                roomMemo.append(i.roomMemo)
                minPersonnel.append(i.minPersonnel)
                maxPersonnel.append(i.maxPersonnel)
//                timePercent.append(i.timePercent)
                timeUse.append(i.timeUse)
                timeSale.append(i.timeSale)
                timePrice.append(i.timePrice)
                sleepCheckin.append(i.sleepCheckin)
//                sleepPercent.append(i.sleepPercent)
                sleepSale.append(i.sleepSale)
                sleepPrice.append(i.sleepPrice)
            }
            
            self.restListTableView.reloadData()
            self.dismissIndicator()
            
        }else {
            self.presentAlert(title: result.message)
        }
        
    }
    func failedToRequest(message : String){
        self.presentAlert(title: message)
    }
    
}

