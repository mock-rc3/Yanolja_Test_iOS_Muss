//
//  bookMainViewController.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/23.
//

import Foundation
import UIKit
import Tabman
import Pageboy

class TabManViewController : TabmanViewController{
    
    var viewControllers: Array<UIViewController> = []
    var tabTitles : Array<String> = ["추천", "국내숙소", "즐길거리", "교통/항공", "해외여행"]
    
    @IBOutlet weak var tempView: UIView! // 상단 탭바 들어갈 자리
    
    
    func settingTabBar(ctBar: TMBar.ButtonBar) {
        //바 설정
        ctBar.layout.transitionStyle = .snap
        ctBar.backgroundView.layer.addBorder([.bottom], color: UIColor.lightGray, width: 0.5)
        ctBar.backgroundView.style = .blur(style: .light)
        ctBar.layout.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 0.0, right: 20)
        ctBar.layout.interButtonSpacing = 20
//        ctBar.layout.alignment = .centerDistributed // .center시 선택된 탭이 가운데로 오게 됨.
        
        ctBar.layout.contentMode = .intrinsic
        
        //버튼 설정
        ctBar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .yanoljaPink
            button.font = .NotoSans(.medium, size: 17)
            button.selectedFont = .NotoSans(.medium, size: 17)
        }
        
        //인디케이터 설정
        ctBar.indicator.weight = .custom(value: 5)
        ctBar.indicator.tintColor = .yanoljaIndicator
        ctBar.indicator.overscrollBehavior = .compress

    }
    
    func printMyFonts() {
        print("--------- Available Font names ----------")

        for name in UIFont.familyNames {
            print(name)
            
            print(UIFont.fontNames(forFamilyName: name))
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printMyFonts()
        
        self.navigationController?.navigationBar.isHidden = true
        
//        tempView.layer.addBorder([.bottom], color: UIColor.lightGray, width: 1)
        
        
        
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

//        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.: UIColor.yanoljaGray]
//        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        

        let vc1 = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "recommendation") as! RecommendationViewController
        let vc2 = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "domestic") as! DomesticViewController
        let vc3 = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "entertainment") as! EntertainmentViewController
        let vc4 = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "transportation") as! TransportationViewController
        let vc5 = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "abroad") as! AbroadViewController
        
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        viewControllers.append(vc5)
        
        self.dataSource = self

        // Create & Customize bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        
        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil))
    }
}

extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = tabTitles[index]
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
