//
//  RecommendationViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class EntertainmentViewController : BaseViewController{
    
    var images = ["배너1", "배너2", "배너3"]
    
    var IconTitle = ["레저&티켓", "스키&썰매", "테마파크특가", "스파워터파크", "아쿠아리움", "모바일교환권", "카페", "치킨", "베이커리", "상품권", "맛집", "홍대맛집", "강남맛집", "압구정맛집", "성수맛집", "아이야놀자", "제주입장권", "부산입장권", "강원입장권", "더보기"]
    
    
    @IBOutlet weak var IconCollectionView: UICollectionView!
    @IBOutlet weak var FirstCollectionView: UICollectionView!
    @IBOutlet weak var SecondCollectionView: UICollectionView!
    
    @IBOutlet weak var stack1: UIView!
    @IBOutlet weak var stack2: UIView!
    @IBOutlet weak var stack3: UIView!
    @IBOutlet weak var stack4: UIView!
    
    
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
        self.FirstCollectionView.delegate = self
        self.FirstCollectionView.dataSource = self
        self.SecondCollectionView.delegate = self
        self.SecondCollectionView.dataSource = self
        
        stack1.layer.borderWidth = 1
        stack1.layer.borderColor = UIColor.VeryLightGray.cgColor
        stack2.layer.borderWidth = 1
        stack2.layer.borderColor = UIColor.VeryLightGray.cgColor
        stack3.layer.borderWidth = 1
        stack3.layer.borderColor = UIColor.VeryLightGray.cgColor
        stack4.layer.borderWidth = 1
        stack4.layer.borderColor = UIColor.VeryLightGray.cgColor
        
        
    }
}

extension EntertainmentViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == IconCollectionView{
            
            let width = (collectionView.frame.width - 30) / 5
            let height = (collectionView.frame.height - 10) / 4
            print("collectionView width=\(collectionView.frame.width)")
            print("first cell하나당 width=\(width)")
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

extension EntertainmentViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == IconCollectionView {
            return IconTitle.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == IconCollectionView {
            let cellOne = IconCollectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCollectionViewCell
            
            cellOne.IconImg.image = UIImage(named: IconTitle[indexPath.row])
            cellOne.IconTitle.text = IconTitle[indexPath.row]
            
            return cellOne
            
        } else if collectionView == FirstCollectionView {
            
            let cellTwo = FirstCollectionView.dequeueReusableCell(withReuseIdentifier: "EntFirstCell", for: indexPath) as! FirstCollectionViewCell
            
            // 전달받은 cell 내용 입력
            
            return cellTwo
            
        } else {
            let cellThree = SecondCollectionView.dequeueReusableCell(withReuseIdentifier: "EntSecondCell", for: indexPath) as! SecondCollectionViewCell
            
            return cellThree
        }
    }
}






