//
//  RecommendationViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class AbroadViewController : BaseViewController{
    
    var IconTitle = ["해외숙소", "해외 항공권", "여행자보험", "더보기"]
    
    @IBOutlet weak var AbroadCollectionView: UICollectionView!
    
    @IBOutlet weak var Abroad1: UIImageView!
    @IBOutlet weak var Abroad2: UIImageView!
    @IBOutlet weak var Abroad3: UIImageView!
    @IBOutlet weak var Abroad4: UIImageView!
    @IBOutlet weak var Abroad5: UIImageView!
    @IBOutlet weak var Abroad6: UIImageView!
    @IBOutlet weak var Abroad7: UIImageView!
    @IBOutlet weak var Abroad8: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Abroad1.layer.cornerRadius = 15
        Abroad2.layer.cornerRadius = 15
        Abroad3.layer.cornerRadius = 15
        Abroad4.layer.cornerRadius = 15
        Abroad5.layer.cornerRadius = 15
        Abroad6.layer.cornerRadius = 15
        Abroad7.layer.cornerRadius = 15
        Abroad8.layer.cornerRadius = 15
        
        
        self.AbroadCollectionView.delegate = self
        self.AbroadCollectionView.dataSource = self
        
        
    }
}

extension AbroadViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        let width = (collectionView.frame.width - 30) / 4
        let height = collectionView.frame.height - 10
        let size = CGSize(width: width, height: height)
        
        return size
            
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
    
}

extension AbroadViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = AbroadCollectionView.dequeueReusableCell(withReuseIdentifier: "abroadCell", for: indexPath) as! AbroadCollectionViewCell
        
        cell.IconTitle.text = IconTitle[indexPath.row]
        cell.IconImg.image = UIImage(named: IconTitle[indexPath.row])
        
        return cell
    }
    
    
}
