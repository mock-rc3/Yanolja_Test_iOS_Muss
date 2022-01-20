//
//  HeartViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/19.
//

import Foundation
import UIKit

class HeartViewController : BaseViewController {
    
    lazy var dataManager : LikeAndReserveDataManager = LikeAndReserveDataManager()
    
    var hotel_id : Array<Int> = []
    var hotel_name : Array<String> = []
    var event : Array<String> = []
    var img : Array<String> = []
    
    var rate = [2.3, 3.5, 4.3, 1.4]
    var timePercent = [40, 30, 20, 10]
    var timePrice = ["20,000원", "30,000원", "10,000원", "40,000원"]
    var timeSale = ["10,000", "20,000", "1,000", "8,000"]
    
    var sleepPercent = [40, 30, 20, 10]
    var sleepPrice = ["50,000원", "40,000원", "60,000원", "70,000원"]
    var sleepCheckin = ["12:00부터", "13:00부터", "14:00부터", "15:00부터"]
    var sleepSale = ["20,000", "30,000", "10,000", "50,000"]

    
    @IBOutlet weak var heartTableView: UITableView!
    
    
    @IBAction func basketBtn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.showMeLikeList(delegate: self)
        self.showIndicator()
        
        self.heartTableView.delegate = self
        self.heartTableView.dataSource = self
    }
}

extension HeartViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if hotel_name.count == 0{
            tableView.setEmptyView(title: "찜한 숙소가 없습니다.", message: "다양한 국내숙소 상품을 만나보세요.", btnMessage: "홈으로 가기")
        } else {
            tableView.restore()
        }
        
        return hotel_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = heartTableView.dequeueReusableCell(withIdentifier: "heartCell") as! HeartTableViewCell
        
        if hotel_name.count == 0{
            
        }
        
        if let url = URL(string: img[indexPath.row]) {
            let data = try? Data(contentsOf: url)
            cell.Img.image = UIImage(data: data!)
        } else {
            print("이미지를 불러올 수 없습니다")
        }
        
        cell.title.text = hotel_name[indexPath.row]
        cell.Rate.rating = rate[indexPath.row]
        cell.Rate.text = "\(rate[indexPath.row])"
        cell.timePercent.text = "\(timePercent[indexPath.row])~"
        cell.timePrice.text = timePrice[indexPath.row]
        cell.timeSale.text = timeSale[indexPath.row]
        cell.sleepPercent.text = "\(sleepPercent[indexPath.row])~"
        cell.sleepPrice.text = sleepPrice[indexPath.row]
        cell.sleepSale.text = sleepSale[indexPath.row]
        cell.sleepCheckin.text = sleepCheckin[indexPath.row]
        cell.Event.text = event[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let NextView = UIStoryboard(name: "SpecificRest", bundle: nil).instantiateViewController(withIdentifier: "specificList") as! SpecificRestViewController
        
        NextView.hotelId = hotel_id[indexPath.row]
        
        self.navigationController?.pushViewController(NextView, animated: true)
    }
}

extension HeartViewController{
    
    func didRetreiveLikeList(result : showLikeList) {
        if result.isSuccess{
            
            for i in result.result {
                hotel_id.append(i.hotel_id)
                hotel_name.append(i.hotel_name)
                event.append(i.event)
                img.append(i.img_url)
            }
            self.dismissIndicator()
            heartTableView.reloadData()
            
        } else {
            self.presentAlert(title: result.message)
        }
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
}


