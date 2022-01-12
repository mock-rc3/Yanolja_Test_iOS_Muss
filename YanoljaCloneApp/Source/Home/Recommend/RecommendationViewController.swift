//
//  RecommendationViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class RecommendationViewController : ScrollandNavigation{
    
    
    var images = ["S배너1", "S배너2", "S배너3"]
    
    var IconTitle = ["첫여행할인", "코인뽑기머신", "지역여행혜택", "나만의쿠폰", "1월혜택모음", "모텔특가", "선착순쿠폰", "무한쿠폰룸", "호텔특가", "펜션특가"]
    

    @IBOutlet weak var IconCollectionView: UICollectionView!
    @IBOutlet weak var RelationCollectionView: UICollectionView!
    
    @IBOutlet weak var BannerImg: UIImageView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    @IBOutlet weak var Price1: UIView!
    @IBOutlet weak var Price2: UIView!
    @IBOutlet weak var Price3: UIView!
    
    
    
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
        
        self.IconCollectionView.delegate = self
        self.IconCollectionView.dataSource = self
        self.RelationCollectionView.delegate = self
        self.RelationCollectionView.dataSource = self
        
        
        Price1.layer.masksToBounds = true
        Price1.layer.cornerRadius = 15
        Price2.layer.masksToBounds = true
        Price2.layer.cornerRadius = 15
        Price3.layer.masksToBounds = true
        Price3.layer.cornerRadius = 15
        
        
    }
}



extension RecommendationViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == IconCollectionView{
            
            let width = (collectionView.frame.width - 30) / 5
            let height = (collectionView.frame.height - 10) / 2
            print("collectionView width=\(collectionView.frame.width)")
            print("cell하나당 width=\(width)")
            let size = CGSize(width: width, height: height)
            
            return size
            
        } else {
            
            let width = collectionView.frame.width / 3 + 20
            let height = (collectionView.frame.height - 20)
            print("collectionView width=\(collectionView.frame.width)")
            print("cell하나당 width=\(width)")
            let size = CGSize(width: width, height: height)
            
            return size
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == IconCollectionView {
            return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
            
        } else {
            return UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == IconCollectionView {
            return 0
            
        } else {
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }

}

extension RecommendationViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == IconCollectionView {
            return IconTitle.count
        }
        if collectionView == RelationCollectionView {
            return 0
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == IconCollectionView {
            let cellOne = IconCollectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! RecommendIconCollectionViewCell
            
            cellOne.IconImg.image = UIImage(named: IconTitle[indexPath.row])
            cellOne.IconTitle.text = IconTitle[indexPath.row]
        
            
            return cellOne
        }
        
        if collectionView == RelationCollectionView {
            let cellTwo = RelationCollectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as! RecommendCollectionViewCell
            
            // 전달받은 cell 내용 입력
            
            
            return cellTwo
        }
        

        return UICollectionViewCell()

    }
}
