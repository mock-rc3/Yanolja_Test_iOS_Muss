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
    
    @IBOutlet weak var FirstCollectionView: UICollectionView!
    @IBOutlet weak var SecondCollectionView: UICollectionView!
    @IBOutlet weak var ThirdCollectionView: UICollectionView!
    @IBOutlet weak var FourthCollectionView: UICollectionView!
    @IBOutlet weak var FifthCollectionView: UICollectionView!
    
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
        
//        self.FirstCollectionView.delegate = self
//        self.FirstCollectionView.dataSource = self
//        self.SecondCollectionView.delegate = self
//        self.SecondCollectionView.dataSource = self
//        self.ThirdCollectionView.delegate = self
//        self.ThirdCollectionView.dataSource = self
//        self.FourthCollectionView.delegate = self
//        self.FourthCollectionView.dataSource = self
//        self.FifthCollectionView.delegate = self
//        self.FifthCollectionView.dataSource = self
        
        self.showIndicator()
    }
}



//extension RecommendationViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            let width = collectionView.frame.width / 3 + 10 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
//            let height = collectionView.frame.height - 3
//            print("collectionView width=\(collectionView.frame.width)")
//            print("cell하나당 width=\(width)")
//            let size = CGSize(width: width, height: height)
//
//            return size
//        }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//            return 10
//        }
//
//}
//
//extension RecommendationViewController : UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return books.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = newBookCollection.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! BookMainCollectionViewCell
//
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.shadowRadius = 10
//        cell.backgroundColor = .white
//
//        cell.bookName.text = books[indexPath.row].title
//        cell.bookDescription.text = books[indexPath.row].description
//
//        if let url = URL(string: books[indexPath.row].coverSmallUrl) {
//            let data = try? Data(contentsOf: url)
//            cell.bookImg.image = UIImage(data: data!)
//        } else {
//            print("cannot conver to Data")
//        }
//
//        return cell
//    }
