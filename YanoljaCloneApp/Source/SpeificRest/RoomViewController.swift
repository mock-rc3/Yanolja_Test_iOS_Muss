//
//  RoomViewControlelr.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/16.
//

import Foundation
import UIKit

class RoomViewController : BaseViewController {
    
    lazy var dataManager : SpecificDataManager = SpecificDataManager()
    
    var hotelId : Int = 0
    var roomId : Int = 0
    
    var Name = ""
    var minPersonnel = ""
    var maxPersonnel = ""
    var price = ""
    var sleepprice = ""
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomInfo: UILabel!
    @IBOutlet weak var roomLimit: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    //대실
    @IBOutlet weak var timeUse: UILabel!
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var timePrice: UILabel!
    @IBOutlet weak var timePercent: UILabel!
    @IBOutlet weak var timeSale: UILabel!
    
    //숙박
    @IBOutlet weak var sleepCheckIn: UILabel!
    @IBOutlet weak var sleepCheckOut: UILabel!
    @IBOutlet weak var sleepPrice: UILabel!
    @IBOutlet weak var sleepPercent: UILabel!
    @IBOutlet weak var sleepSale: UILabel!
    
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var sleepView: UIView!
    
    //하단 뷰
    
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var TimeReservation: UIView!
    @IBOutlet weak var SleepReservation: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let timeTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeResverve(sender:)))
        let sleepTapGesture = UITapGestureRecognizer(target: self, action: #selector(sleepReserve(sender:)))
        TimeReservation.addGestureRecognizer(timeTapGesture)
        SleepReservation.addGestureRecognizer(sleepTapGesture)
        
        
        timeView.layer.addBorder([.top, .left, .right], color: UIColor.lightGray, width: 0.5)
        sleepView.layer.addBorder([.top, .left, .right], color: UIColor.lightGray, width: 0.5)
        
        bottomBar.addShadow(location: .top)
        
        TimeReservation.layer.cornerRadius = 10
        SleepReservation.layer.cornerRadius = 10
        
    
        if let text = timePrice.text {
          let attributeString = NSMutableAttributedString(string: text)

          attributeString.addAttribute(.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributeString.length))

            timePrice.attributedText = attributeString
        }
        if let text = sleepPrice.text {
          let attributeString = NSMutableAttributedString(string: text)

          attributeString.addAttribute(.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributeString.length))

            sleepPrice.attributedText = attributeString
        }
        
        
        dataManager.requestSpecificRoomList(startDate: "2022-01-15", endDate: "2022-01-16", days: "weekday", hotelId: hotelId, roomId: roomId, delegate: self)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func timeResverve(sender : UITapGestureRecognizer) {
        
        let TSV = self.storyboard?.instantiateViewController(withIdentifier: "timeSelectView") as! timeSelectViewController
        
        TSV.Name = Name
        TSV.minPersonnel = minPersonnel
        TSV.maxPersonnel = maxPersonnel
        TSV.price = price
        TSV.hotelId = hotelId
        TSV.roomId = roomId
        
        TSV.modalPresentationStyle = .overCurrentContext
        TSV.modalTransitionStyle = .coverVertical
        
        self.present(TSV, animated: true)
    }
    
    
    @objc func sleepReserve(sender : UITapGestureRecognizer) {
        
        let SV = self.storyboard?.instantiateViewController(withIdentifier: "sleepView") as! sleepReserveViewController
        
        SV.Name = Name
        SV.minPersonnel = minPersonnel
        SV.maxPersonnel = maxPersonnel
        SV.price = price
        SV.hotelId = hotelId
        SV.roomId = roomId
        
        SV.modalTransitionStyle = .coverVertical
        SV.modalPresentationStyle = .overFullScreen
        self.present(SV, animated: true)
        
    }
}

extension RoomViewController {
    
    func didRetreiveRoomInfo(result : RoomResponse) {
        if result.isSuccess{
            self.Name = result.result.roomInfo.roomName
            self.price = result.result.roomInfo.timeSale
            self.minPersonnel = result.result.roomInfo.minPersonnel
            self.maxPersonnel = result.result.roomInfo.maxPersonnel
            self.sleepprice = result.result.roomInfo.sleepSale
            
            self.roomName.text = result.result.roomInfo.roomName
            self.roomInfo.text = result.result.roomInfo.roomMemo
            self.roomLimit.text = "기준 인원 \(result.result.roomInfo.minPersonnel)명 (최대\(result.result.roomInfo.maxPersonnel)명)"
            self.hotelName.text = result.result.roomInfo.hotelName
            
            if let img = result.result.roomImg[1]{
                if let url = URL(string: img) {
                    let data = try? Data(contentsOf: url)
                    self.roomImg.image = UIImage(data: data!)
                }
            }
            
            self.timeUse.text = "최대\(result.result.roomInfo.timeUse)시간"
            self.timeRange.text = "\(result.result.roomInfo.timeStart) ~ \(result.result.roomInfo.timeEnd)"
            self.timePrice.text = "\(result.result.roomInfo.timePrice)원"
            self.timePercent.text = "\(result.result.roomInfo.timePercent)%"
            self.timeSale.text = result.result.roomInfo.timeSale
            
            self.sleepCheckIn.text = "\(result.result.roomInfo.sleepCheckIn) 부터"
            self.sleepCheckOut.text = "\(result.result.roomInfo.sleepCheckOut) 까지"
            self.sleepPrice.text = "\(result.result.roomInfo.sleepPrice)원"
            self.sleepPercent.text = "\(result.result.roomInfo.sleepPercent)%"
            self.sleepSale.text = "\(result.result.roomInfo.sleepSale)"
            
        } else{
            self.presentAlert(title: result.message)
        }
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
}
