//
//  RoomViewControlelr.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/16.
//

import Foundation
import UIKit

class RoomViewController : BaseViewController {
    
//    lazy var dataManager
    
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
    @IBOutlet weak var TimeReservation: UIView!
    @IBOutlet weak var SleepReservation: UIView!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timeTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeResverve(sender:)))
        let sleepTapGesture = UITapGestureRecognizer(target: self, action: #selector(sleepReserve(sender:)))
        TimeReservation.addGestureRecognizer(timeTapGesture)
        SleepReservation.addGestureRecognizer(sleepTapGesture)
        
        
        timeView.layer.addBorder([.top, .left, .right], color: UIColor.lightGray, width: 0.5)
        sleepView.layer.addBorder([.top, .left, .right], color: UIColor.lightGray, width: 0.5)
        
    
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
        
        
        
    }
    
    @objc func timeResverve(sender : UITapGestureRecognizer) {
        
        let TSV = self.storyboard?.instantiateViewController(withIdentifier: "timeSelectView")
        if let presentationController = TSV!.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        self.present(TSV!, animated: true)
    }
    
    @objc func sleepReserve(sender : UITapGestureRecognizer) {
        
        let SV = self.storyboard?.instantiateViewController(withIdentifier: "sleepView")
        self.navigationController?.pushViewController(SV!, animated: true)
    }
}

extension RoomViewController {
    func didRetreiveRoomInfo(result : RoomResponse) {
        if result.isSuccess{
            
        } else{
            
        }
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
}
