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
    
    
//    "roomName": "Deluxe",
//    "roomMemo": "넷플릭스 가능",
//    "minPersonnel": "2",
//    "maxPersonnel": "2",
//    "timeUse": "1",
//    "timePrice": "35,000",
//    "timeSale": "22,000",
//    "sleepCheckin": "19:00",
//    "sleepPrice": "90,000",
//    "sleepSale": "36,000"
    
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var HotelTitle: UILabel!
    @IBOutlet weak var HotelRate: UILabel!
    @IBOutlet weak var loacationMemo: UILabel!
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
        
        dataManager.requestSpecificRestList(startDate: "2022-01-09", endDate: "2022-01-10", days: "weekend", hotelId: hotelId, delegate: self)
        self.showIndicator()
        
        view1.layer.addBorder([.all], color: UIColor.emailBlue, width: 1)
        view1.layer.cornerRadius = 15
        
        view2.layer.addBorder([.top, .bottom], color: UIColor.lightGray, width: 0.5)
        view2.layer.cornerRadius = 15
        
        view3.layer.addBorder([.top, .bottom], color: UIColor.lightGray, width: 0.5)
        
        view4.layer.addBorder([.bottom], color: UIColor.lightGray, width: 0.5)
        
        
    }
}

extension SpecificRestViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = restListTableView.dequeueReusableCell(withIdentifier: "restSpecificCell", for: indexPath) as! RestTableViewCell
        
        return cell
    }
}

extension SpecificRestViewController {
    
    func didRetrieveRestList(result: SpecificResponse){
        if result.isSuccess {
            
            for i in result.result.roomList {
                
            }
            
        }else {
            
        }
        
    }
    func failedToRequest(message : String){
        self.presentAlert(title: message)
    }
    
}

