//
//  ReserveTableViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/20.
//

import UIKit

class ReserveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reserveId: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
