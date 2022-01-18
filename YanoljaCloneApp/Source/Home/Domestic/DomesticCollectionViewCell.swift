//
//  DomesticCollectionViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/11.
//

import UIKit
import Cosmos

class DomesticCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var RestImg: UIImageView!
    @IBOutlet weak var RestTitle: UILabel!
    @IBOutlet weak var CosmosView: CosmosView!
    @IBOutlet weak var RestDiscountRate: UILabel!
    @IBOutlet weak var RestCost: UILabel!
    
    
    override func awakeFromNib() {
        CosmosView.settings.updateOnTouch = false
        CosmosView.settings.starMargin = 1
        CosmosView.settings.fillMode = .precise
        CosmosView.settings.starSize = 15
        CosmosView.settings.textFont = UIFont.boldSystemFont(ofSize: 15)
        CosmosView.settings.textColor = .black
    }
    
    
}
