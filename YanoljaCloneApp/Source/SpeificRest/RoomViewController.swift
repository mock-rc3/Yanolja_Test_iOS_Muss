//
//  RoomViewControlelr.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/16.
//

import Foundation
import UIKit

class RoomViewController : BaseViewController {
    
    
    @IBOutlet weak var TimeReservation: UIView!
    @IBOutlet weak var SleepReservation: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timeTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeResverve(sender:)))
        let sleepTapGesture = UITapGestureRecognizer(target: self, action: #selector(sleepReserve(sender:)))
        TimeReservation.addGestureRecognizer(timeTapGesture)
        SleepReservation.addGestureRecognizer(sleepTapGesture)
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
