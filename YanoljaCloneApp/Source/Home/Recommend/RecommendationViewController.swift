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
    
    var IconTitle = ["첫여행 할인", "코인뽑기머신", "지역여행혜택", "나만의쿠폰", "1월혜택모음", "모텔특가", "선착순쿠폰", "무한쿠폰룸", "호텔특가", "펜션특가"]
    

    @IBOutlet weak var IconCollectionView: UICollectionView!
    @IBOutlet weak var RelationCollectionView: UICollectionView!
    
    @IBOutlet weak var BannerImg: UIImageView!
    @IBOutlet weak var PageControl: UIPageControl!
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
        
        
        
    }
}



extension RecommendationViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == IconCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
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
