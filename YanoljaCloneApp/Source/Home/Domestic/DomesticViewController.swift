//
//  RecommendationViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class DomesticViewController : BaseViewController {
    
    var images = ["Banner1", "Banner2", "Banner3"]
    
    var IconTitle = ["모텔", "호텔", "프리미엄호텔", "펜션&풀빌라", "프리미엄펜션", "리조트", "글램핑&캠핑", "게하&한옥", "호캉스패키지", "스파펜션", "부티크브랜드", "QR체크인", "야놀자케어", "대실할인", "얼리버드특가", "지역여행혜택", "부산", "제주도", "Top랭킹", "더보기"]
    
    
    @IBOutlet weak var IconCollectionView: UICollectionView!
    @IBOutlet weak var DomesticCollectionView: UICollectionView!
    @IBOutlet weak var DomesticTableView: UITableView!
    
    @IBOutlet weak var stack1: UIView!
    @IBOutlet weak var stack2: UIView!
    @IBOutlet weak var stack3: UIView!
    @IBOutlet weak var stack4: UIView!
    
    @IBOutlet weak var BannerImg: UIImageView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    @IBOutlet weak var Banner1: UIImageView!
    @IBOutlet weak var Banner2: UIImageView!
    @IBOutlet weak var Banner3: UIImageView!
    
    
    
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
        self.DomesticCollectionView.delegate = self
        self.DomesticCollectionView.dataSource = self
        self.DomesticTableView.delegate = self
        self.DomesticTableView.dataSource = self
        
        stack1.layer.borderWidth = 1
        stack1.layer.borderColor = UIColor.VeryLightGray.cgColor
        stack2.layer.borderWidth = 1
        stack2.layer.borderColor = UIColor.VeryLightGray.cgColor
        stack3.layer.borderWidth = 1
        stack3.layer.borderColor = UIColor.VeryLightGray.cgColor
        stack4.layer.borderWidth = 1
        stack4.layer.borderColor = UIColor.VeryLightGray.cgColor
        
        Banner1.layer.cornerRadius = 15
        Banner2.layer.cornerRadius = 15
        Banner3.layer.cornerRadius = 15
        
    }
}

extension DomesticViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
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

extension DomesticViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == IconCollectionView {
            return IconTitle.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == IconCollectionView {
            let cellOne = IconCollectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! DomesticIconCollectionViewCell
            
            cellOne.IconImg.image = UIImage(named: IconTitle[indexPath.row])
            cellOne.IconTitle.text = IconTitle[indexPath.row]
        
            
            return cellOne
            
        }else {
            
            let cellTwo = DomesticCollectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as! RecommendCollectionViewCell
            
            // 전달받은 cell 내용 입력
            
            
            return cellTwo
        }
    }
}

extension DomesticViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = DomesticTableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath)
        
        return cell
    }
}




