//
//  RestTableViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/15.
//

import UIKit

class RestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomMemo: UILabel!
    @IBOutlet weak var Personnel: UILabel!
    @IBOutlet weak var timeUse: UILabel!
    @IBOutlet weak var timePrice: UILabel!
    @IBOutlet weak var timeSale: UILabel!
    @IBOutlet weak var sleepCheckin: UILabel!
    @IBOutlet weak var sleepPrice: UILabel!
    @IBOutlet weak var sleepSale: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
