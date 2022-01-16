//
//  RestListTableViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/14.
//

import UIKit
import Cosmos

class RestListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellLocation: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellRate: CosmosView!
    
    @IBOutlet weak var cellRentOriginalPrice: UILabel!
    @IBOutlet weak var cellRentDiscountRate: UILabel!
    @IBOutlet weak var cellRentPrice: UILabel!
    @IBOutlet weak var cellRentTimeUse: UILabel!
    
    @IBOutlet weak var cellSleepDiscountRate: UILabel!
    @IBOutlet weak var cellSleepOriginalPrice: UILabel!
    @IBOutlet weak var cellSleepPrice: UILabel!
    @IBOutlet weak var cellSleepStart: UILabel!
    
    @IBOutlet weak var cellEvent: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
