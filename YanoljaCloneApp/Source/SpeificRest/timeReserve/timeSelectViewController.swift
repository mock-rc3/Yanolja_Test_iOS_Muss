//
//  timeSelectViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/16.
//

import Foundation
import UIKit

class timeSelectViewController : UIViewController {
    
    var Name = ""
    var maxPersonnel = ""
    var minPersonnel = ""
    var price = ""
    

    @IBOutlet weak var One: UILabel!
    @IBOutlet weak var Two: UILabel!
    @IBOutlet weak var Three: UILabel!
    @IBOutlet weak var Four: UILabel!
    @IBOutlet weak var Five: UILabel!
    @IBOutlet weak var Six: UILabel!
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        One.addGestureRecognizer(tapGesture)
        Two.addGestureRecognizer(tapGesture)
        Three.addGestureRecognizer(tapGesture)
        Four.addGestureRecognizer(tapGesture)
        Five.addGestureRecognizer(tapGesture)
        Six.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let TRVC = self.storyboard?.instantiateViewController(withIdentifier: "timeView") as! timeReserveViewController
        
        TRVC.timeCheckIn.text = One.text?.substring(from: 0, to: 4)
        TRVC.timeCheckOut.text = One.text?.substring(from: 6, to: 10)
        TRVC.Name = self.Name
        TRVC.maxPersonnel = self.maxPersonnel
        TRVC.minPersonnel = self.minPersonnel
        TRVC.price = self.price
        
        TRVC.modalTransitionStyle = .coverVertical
        TRVC.modalPresentationStyle = .overFullScreen
        self.present(TRVC, animated: true)
    }
}
