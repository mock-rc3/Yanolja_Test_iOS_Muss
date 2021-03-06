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
        if let text = cellRentOriginalPrice.text {
          let attributeString = NSMutableAttributedString(string: text)

          attributeString.addAttribute(.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributeString.length))

            cellRentOriginalPrice.attributedText = attributeString
        }
        
        if let text = cellSleepOriginalPrice.text {
          let attributeString = NSMutableAttributedString(string: text)

          attributeString.addAttribute(.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributeString.length))

            cellSleepOriginalPrice.attributedText = attributeString
        }
        
        
        cellRate.settings.updateOnTouch = false
        cellRate.settings.starMargin = 1
        cellRate.settings.fillMode = .precise
        cellRate.settings.starSize = 15
        cellRate.settings.textFont = UIFont.boldSystemFont(ofSize: 15)
        cellRate.settings.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
