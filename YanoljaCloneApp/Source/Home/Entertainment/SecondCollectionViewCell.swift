//
//  SecondCollectionViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/12.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CellImg: UIImageView!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellDiscountRate: UILabel!
    @IBOutlet weak var CellCost: UILabel!
    
    override func awakeFromNib() {
        CellImg.layer.cornerRadius = 10
    }
}
