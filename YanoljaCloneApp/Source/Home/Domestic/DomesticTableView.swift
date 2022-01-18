//
//  DomesticCollectionViewCell.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/11.
//

import UIKit
import Cosmos

class DomesticTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var RestImg: UIImageView!
    @IBOutlet weak var RestTitle: UILabel!
    @IBOutlet weak var CosmosView: CosmosView!
    @IBOutlet weak var RestDiscountRate: UILabel!
    @IBOutlet weak var RestCost: UILabel!
    
    
    
    override func awakeFromNib() {
        
        RestImg.layer.cornerRadius = 10
        
        CosmosView.settings.updateOnTouch = false
        CosmosView.settings.starMargin = 1
        CosmosView.settings.fillMode = .precise
        
    }
}
