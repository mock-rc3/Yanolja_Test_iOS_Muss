//
//  RecommendationViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class TransportationViewController : BaseViewController{
    
    var images = ["1", "2", "3"]
    var IconTitle = ["고속버스", "KTX", "렌터카", "항공권", "더보기"]
    
    @IBOutlet weak var TransIconCollectionView: UICollectionView!
    
    @IBOutlet weak var BannerImg: UIImageView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    
    @IBOutlet weak var Weekend1: UIImageView!
    @IBOutlet weak var Weekend2: UIImageView!
    @IBOutlet weak var Weekend3: UIImageView!
    
    @IBOutlet weak var Where1: UIImageView!
    @IBOutlet weak var Where2: UIImageView!
    @IBOutlet weak var Where3: UIImageView!
    @IBOutlet weak var Where4: UIImageView!
    
    
    @IBAction func PageChanged(_ sender: Any) {
        
        BannerImg.image = UIImage(named: images[PageControl.currentPage])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //페이지 컨트롤의 전체 페이지를 images 배열의 전체 개수 값으로 설정
        PageControl.numberOfPages = images.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        PageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        PageControl.pageIndicatorTintColor = UIColor.lightGray
        // 현재 페이지 표시 색상을 검정색으로 설정
        PageControl.currentPageIndicatorTintColor = UIColor.black
        BannerImg.image = UIImage(named: images[0])
        
        Weekend1.layer.cornerRadius = 15
        Weekend2.layer.cornerRadius = 15
        Weekend3.layer.cornerRadius = 15
        
        Where1.layer.cornerRadius = 15
        Where2.layer.cornerRadius = 15
        Where3.layer.cornerRadius = 15
        Where4.layer.cornerRadius = 15
        
        
        self.TransIconCollectionView.delegate = self
        self.TransIconCollectionView.dataSource = self
    }
}

extension TransportationViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        let width = (collectionView.frame.width - 30) / 5
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

extension TransportationViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IconTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = TransIconCollectionView.dequeueReusableCell(withReuseIdentifier: "transCell", for: indexPath) as! TransIconCollectionViewCell
        
        cell.IconTitle.text = IconTitle[indexPath.row]
        cell.IconImg.image = UIImage(named: IconTitle[indexPath.row])
        
        return cell
    }
    
    
}
