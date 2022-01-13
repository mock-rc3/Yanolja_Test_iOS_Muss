//
//  LargeRegionTableViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/13.
//

import UIKit

class LargeRegionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellName: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if selected {
            contentView.backgroundColor = UIColor.white
            cellName.textColor = UIColor.black
        } else {
            contentView.backgroundColor = UIColor(red: 244/255, green: 243/255, blue: 243/255, alpha: 1)
            cellName.textColor = UIColor(red: 165/255, green: 165/255, blue: 164/255, alpha: 1)
        }
    }
}
