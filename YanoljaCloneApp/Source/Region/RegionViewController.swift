//
//  LargeRegionViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/13.
//

import Foundation
import UIKit
import Alamofire

class RegionViewController : BaseViewController {
    
    lazy var dataManager : RegionDataManager = RegionDataManager()
    var mainArea : Array<String> = []
    var subArea : Array<String> = []
    
    var closeCheck : Bool = true
    
    @IBOutlet weak var LargeTableView: UITableView!
    @IBOutlet weak var SmallTableView: UITableView!
    
    @IBOutlet weak var CloseViewBtn: UIButton!
    @IBOutlet weak var SearchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CloseViewBtn.isHidden = closeCheck
        self.navigationController?.navigationBar.isHidden = true
        
        self.LargeTableView.delegate = self
        self.LargeTableView.dataSource = self
        self.SmallTableView.delegate = self
        self.SmallTableView.dataSource = self
        
        
        self.dataManager.InquireRegion(delegate: self)
        self.showIndicator()
    }
    
    @IBAction func CloseView(_ sender: Any) {
        closeCheck = false
        self.dismiss(animated: true)
    }
    
    
    
}

extension RegionViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == SmallTableView {
            let RLVC = self.storyboard?.instantiateViewController(withIdentifier: "restListView") as! RestListViewController
            
            RLVC.areaId = indexPath.row + 1
            print(subArea)
            
            RLVC.SpecificLocation = subArea[indexPath.row]
            self.navigationController?.pushViewController(RLVC, animated: true)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == LargeTableView {
            return mainArea.count
        } else{
            return subArea.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == LargeTableView{
            
            let cell = LargeTableView.dequeueReusableCell(withIdentifier: "largeCell", for: indexPath) as! LargeRegionTableViewCell
            
            cell.cellName.text = mainArea[indexPath.row]
            return cell
            
        } else {
            let cell = SmallTableView.dequeueReusableCell(withIdentifier: "smallCell", for: indexPath) as! SmallRegionTableViewCell
            
            let background = UIView()
            background.backgroundColor = .clear
            cell.selectedBackgroundView = background
            
            cell.cellName.text = subArea[indexPath.row]
            return cell
        }
    }
}

extension RegionViewController {
    func didRetrieveRegionInfo (result : RegionResponse){
        
        if result.isSuccess {
            for i in result.result.mainArea{
                mainArea.append(i)
            }
            
            for s in result.result.subArea{
                subArea.append(s)
            }
            
            self.LargeTableView.reloadData()
            self.SmallTableView.reloadData()
            
            self.dismissIndicator()
            
        } else {
            self.presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
