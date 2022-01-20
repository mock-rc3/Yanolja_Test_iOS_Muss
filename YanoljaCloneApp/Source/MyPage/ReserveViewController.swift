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
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var dateView: UIView!
    
    
    @IBOutlet weak var reserveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        categoryView.layer.borderWidth = 1
        categoryView.layer.borderColor = UIColor.darkGray.cgColor
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.darkGray.cgColor
        
        
        dataManager.showMeReserveList(delegate: self)
        self.showIndicator()
        
        self.reserveTableView.delegate = self
        self.reserveTableView.dataSource = self
    }
    
    
//    @IBAction func deleteReserve(_ sender: Any) {
//        dataManager.deleteReservedRoom(userId: Constant.user_id, reserveId: <#T##Int#>, delegate: self)
//    }
    
    
    @IBAction func popView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension ReserveViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if reserveId.count == 0{
            tableView.setEmptyView(title: "최근 3개월 예약내역이 없습니다.", message: "상품을 예약해보세요", btnMessage: "홈으로 가기")
        } else {
            tableView.restore()
        }
        
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
        cell.roomName.text = roomName[indexPath.row]
        cell.startDate.text = startDate[indexPath.row].substring(from: 0, to: 3) + "." + startDate[indexPath.row].substring(from: 4, to: 5) + "." + startDate[indexPath.row].substring(from: 6, to: 7) + " (목)"
        cell.time.text = "\(time[indexPath.row]) 시간"
        cell.startTime.text = startTime[indexPath.row].substring(from: 0, to: 1) + ":" + startTime[indexPath.row].substring(from: 2, to: 3)
        cell.endTime.text = endTime[indexPath.row].substring(from: 0, to: 1) + ":" + endTime[indexPath.row].substring(from: 2, to: 3)
        cell.startDate.text = startDate[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 309
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
                time.append(Int(i.time ?? "4") ?? 4)
                startTime.append(i.bookingStartTime ?? "1000")
                endTime.append(i.bookingEndTime ?? "2000")
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

extension ReserveViewController {
    func didDeleteReservation(result : DeleteReserveResponse) {
        if result.isSuccess{
            self.presentAlert(title: result.message)
            self.reserveTableView.reloadData()
        } else {
            self.presentAlert(title: result.message)
        }
    }
    func failedToDelete(message : String) {
        self.presentAlert(title: message)
    }
}
