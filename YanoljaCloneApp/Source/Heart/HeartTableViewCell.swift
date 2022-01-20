//
//  HeartTableViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/19.
//

import Foundation
import Cosmos

class HeartTableViewCell : UITableViewCell {
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Rate: CosmosView!
    
    @IBOutlet weak var timePercent: UILabel!
    @IBOutlet weak var timePrice: UILabel!
    @IBOutlet weak var timeUse: UILabel!
    @IBOutlet weak var timeSale: UILabel!
    
    @IBOutlet weak var sleepPercent: UILabel!
    @IBOutlet weak var sleepPrice: UILabel!
    @IBOutlet weak var sleepCheckin: UILabel!
    @IBOutlet weak var sleepSale: UILabel!
    
    @IBOutlet weak var Event: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Rate.settings.updateOnTouch = false
        Rate.settings.starMargin = 1
        Rate.settings.fillMode = .precise
        Rate.settings.starSize = 15
        Rate.settings.textFont = UIFont.boldSystemFont(ofSize: 15)
        Rate.settings.textColor = .black
    }
    
}
