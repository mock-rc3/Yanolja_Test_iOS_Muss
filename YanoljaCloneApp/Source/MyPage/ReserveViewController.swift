//
//  ReserveViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/20.
//

import Foundation
import UIKit

class ReserveViewController : BaseViewController {
    
    lazy var dataManager : LikeAndReserveDataManager = LikeAndReserveDataManager()
    
    var reserveId : Array<Int> = []
    var img : Array<String> = []
    var hotelName : Array<String> = []
    var roomName : Array<String> = []
    var startDate : Array<String> = []
    var time : Array<Int> = []
    var startTime : Array<String> = []
    var endTime : Array<String> = []
    
    
    
    @IBOutlet weak var reserveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.showMeReserveList(delegate: self)
        self.showIndicator()
        
        self.reserveTableView.delegate = self
        self.reserveTableView.dataSource = self
    }
}

extension ReserveViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reserveId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reserveTableView.dequeueReusableCell(withIdentifier: "reserveCell") as! ReserveTableViewCell
        
        cell.reserveId.text = "숙소 예약번호 \(reserveId[indexPath.row])"
        
        if let url = URL(string: img[indexPath.row]) {
            let data = try? Data(contentsOf: url)
            cell.img.image = UIImage(data: data!)
        }
        
        cell.title.text = hotelName[indexPath.row]
        cell.roomName.text = roomName[indexPath.row].substring(from: 0, to: 3) + "." + roomName[indexPath.row].substring(from: 4, to: 5) + "." + roomName[indexPath.row].substring(from: 6, to: 7) + " (목)"
        cell.time.text = "\(time[indexPath.row]) 시간"
        cell.startTime.text = startTime[indexPath.row].substring(from: 0, to: 1) + ":" + startTime[indexPath.row].substring(from: 2, to: 3)
        cell.endTime.text = endTime[indexPath.row].substring(from: 0, to: 1) + ":" + endTime[indexPath.row].substring(from: 2, to: 3)
        cell.startDate.text = startDate[indexPath.row]
        
        return cell
    }
}

extension ReserveViewController {
    func didRetreiveReserveList(result : ReserveResponse) {
        
        if result.isSuccess{
            for i in result.result[0] {
                reserveId.append(i.roomBookingID)
                img.append(i.imgURL)
                hotelName.append(i.hotelName)
                roomName.append(i.roomName)
                startDate.append(i.bookingStartDate)
                time.append(Int(i.time) ?? 0)
                startTime.append(i.bookingStartTime)
                endTime.append(i.bookingEndTime)
            }
            
            self.dismissIndicator()
            self.reserveTableView.reloadData()
            
            
        } else {
            self.presentAlert(title: result.message)
        }
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
}
