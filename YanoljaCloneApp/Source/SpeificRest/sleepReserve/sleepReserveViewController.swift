//
//  timeReserveViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/16.
//

import Foundation
import UIKit

class sleepReserveViewController : UIViewController {
    
    var Name = ""
    var maxPersonnel = ""
    var minPersonnel = ""
    var price = ""
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomLimit: UILabel!
    
    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var timeDate2: UILabel!
    @IBOutlet weak var timeCheckIn: UILabel!
    @IBOutlet weak var timeCheckOut: UILabel!
    @IBOutlet weak var sleepPrice: UILabel!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var basketView: UIView!
    @IBOutlet weak var reserveView: UIView!
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
        initializeView()
        
        let reserveTapGesture = UITapGestureRecognizer(target: self, action: #selector(reserve(sender:)))
        let basketTapGesture = UITapGestureRecognizer(target: self, action: #selector(basket(sender:)))
        reserveView.addGestureRecognizer(reserveTapGesture)
        basketView.addGestureRecognizer(basketTapGesture)
    }
    
    
    func initialization() {
        roomName.text = Name
        roomLimit.text = "기준 \(minPersonnel)명 / 최대 \(maxPersonnel)명"
        sleepPrice.text = "\(price)원"
        
    }
    
    func initializeView() {
        timeView.layer.addBorder([.top, .bottom, .right, .left], color: UIColor.darkGray, width: 0.5)
        cancelView.layer.addBorder([.top], color: UIColor.darkGray, width: 0.5)
        
        bottomBar.addShadow(location: .top)
        
        basketView.layer.addBorder([.top, .bottom, .left, .right], color: UIColor.yanoljaPink, width: 0.5)
        basketView.layer.cornerRadius = 15
        reserveView.layer.cornerRadius = 15
    }
    
    @objc func reserve(sender: UITapGestureRecognizer) {
        return
    }
    @objc func basket(sender: UITapGestureRecognizer) {
        return
    }
}
