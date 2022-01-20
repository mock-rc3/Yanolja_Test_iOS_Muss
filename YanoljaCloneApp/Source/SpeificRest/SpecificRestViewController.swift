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
    lazy var likeDataManager : LikeAndReserveDataManager = LikeAndReserveDataManager()
    var hotelId : Int = 0
    
    var roomName : Array<String> = []
    var roomImg : Array<String> = []
    var roomMemo : Array<String> = []
    var roomId : Array<Int> = []
    var minPersonnel : Array<String> = []
    var maxPersonnel : Array<String> = []
    var timePercent : Array<Int> = []
    var timeUse : Array<String> = []
    var timePrice : Array<String> = []
    var timeSale : Array<String> = []
    var sleepCheckin : Array<String> = []
    var sleepPercent : Array<Int> = []
    var sleepPrice : Array<String> = []
    var sleepSale : Array<String> = []
    
    var likeId : Int?
    
    
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
    
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var heartImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        view1.layer.addBorder([.top, .bottom, .left, .right], color: UIColor.emailBlue, width: 1)
        view1.layer.cornerRadius = 10
        
        view2.layer.addBorder([.top, .bottom], color: UIColor.lightGray, width: 0.5)
        
        view3.layer.addBorder([.top, .bottom], color: UIColor.lightGray, width: 0.5)
        
        view4.layer.addBorder([.bottom], color: UIColor.lightGray, width: 0.5)
        
        
        heartView.layer.addBorder([.top, .bottom, .left, .right], color: UIColor.lightGray, width: 0.5)
        heartView.layer.cornerRadius = 10 
        
        selectView.layer.cornerRadius = 10
        
        //찜 했는지 여부에 따라 하트 색깔 바뀜
        likeInitialization()
        
        let LikeClick = UITapGestureRecognizer(target: self, action: #selector(sendHotelId(sender:)))
        heartView.addGestureRecognizer(LikeClick)
            
        dataManager.requestSpecificRestList(startDate: "2022-01-15", endDate: "2022-01-16", days: "weekday", hotelId: hotelId, delegate: self)
    
        self.showIndicator()
        
        
        self.restListTableView.delegate = self
        self.restListTableView.dataSource = self
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendHotelId(sender : UITapGestureRecognizer) {
        
        if Constant.ud.bool(forKey: "\(self.hotelId)") {
            heartImg.image = UIImage(named: "하트")
            likeDataManager.deleteLikeItem(delegate: self)
        }
        
        likeDataManager.likeHotel(hotel_id: self.hotelId, delegate: self)
        self.showIndicator()
    }
    
    func likeInitialization() {
        if Constant.ud.bool(forKey: "\(self.hotelId)") {
            heartImg.image = UIImage(named: "하트")
        } else {
            heartImg.image = UIImage(named: "찜했음")
        }
    }
    
    
    
    
}

extension SpecificRestViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = restListTableView.dequeueReusableCell(withIdentifier: "restSpecificCell", for: indexPath) as! RestTableViewCell
        
        cell.roomName.text = roomName[indexPath.row]
        if let url = URL(string: roomImg[indexPath.row]) {
            let data = try? Data(contentsOf: url)
            cell.cellImg.image = UIImage(data: data!)
        }
        cell.roomMemo.text = roomMemo[indexPath.row]
        cell.Personnel.text = "기준 \(minPersonnel[indexPath.row])명 / 최대 \(maxPersonnel[indexPath.row])명"
        cell.timeUse.text = "최대 \(timeUse[indexPath.row])시간"
        cell.timePercent.text = "\(timePercent[indexPath.row])%"
        cell.timePrice.text = "\(timePrice[indexPath.row])원"
        cell.timeSale.text = "\(timeSale[indexPath.row])원"
        cell.sleepCheckin.text = "\(sleepCheckin[indexPath.row])부터"
        cell.sleepPercent.text = "\(sleepPercent[indexPath.row])%"
        cell.sleepSale.text = "\(sleepSale[indexPath.row])원"
        cell.sleepPrice.text = "\(sleepPrice[indexPath.row])원"
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextPhase = self.storyboard?.instantiateViewController(withIdentifier: "roomView") as! RoomViewController
        NextPhase.roomId = roomId[indexPath.row]
        NextPhase.hotelId = self.hotelId
        
        self.navigationController?.pushViewController(NextPhase, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 326
    }
}

extension SpecificRestViewController {
    
    func didRetrieveRestList(result: SpecificResponse){
        if result.isSuccess {
            
            print("success!@!@!@")
            
            if let url = URL(string: result.result.hotelImg[0]){
                let data = try? Data(contentsOf: url)
                mainImg.image = UIImage(data: data!)
            } else {
                print("이미지를 불러올 수 없습니다.")
            }
            HotelTitle.text = result.result.hotelInfo.hotelName
            HotelRate.text = result.result.hotelInfo.rating
            locationMemo.text = result.result.hotelInfo.locationMemo
            
            
            for i in result.result.roomList {
                roomId.append(i.roomId)
                roomName.append(i.roomName)
                roomImg.append(i.roomImg)
                roomMemo.append(i.roomMemo)
                minPersonnel.append(i.minPersonnel)
                maxPersonnel.append(i.maxPersonnel)
                timePercent.append(i.timePercent)
                timeUse.append(i.timeUse)
                timeSale.append(i.timeSale)
                timePrice.append(i.timePrice)
                sleepCheckin.append(i.sleepCheckin)
                sleepPercent.append(i.sleepPercent)
                sleepSale.append(i.sleepSale)
                sleepPrice.append(i.sleepPrice)
            }
            print("success!!!!!!")
            
            self.restListTableView.reloadData()
            self.dismissIndicator()
            
        }else {
            self.presentAlert(title: result.message)
        }
    }
    
    func deleteSuccess(result : DeleteLikeResponse) {
        
        self.presentAlert(title: result.message)
    }
    
    func failedToRequest(message : String){
        self.presentAlert(title: message)
    }
    
}

extension SpecificRestViewController{
    
    func didRetreiveLikeInfo(result : LikeResponse) {
        if result.isSuccess{
            Constant.likeId = result.result.id
            self.dismissIndicator()
            self.presentAlert(title: "찜 목록에 저장했습니다")
        } else {
            self.presentAlert(title: result.message)
        }
    }
    func failedToRequestLikeId(message : String) {
        self.presentAlert(title: message)
    }
}

