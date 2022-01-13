//
//  AppDelegate.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/08.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    class var yanoljaPink: UIColor { UIColor(red: 254/255, green: 51/255, blue: 120/255, alpha: 1)}
    class var yanoljaGray: UIColor {UIColor(red: 187/255, green: 187/255, blue: 186/255, alpha: 1)}
    class var yanoljaIndicator: UIColor{UIColor(red: 200/255, green: 2/255, blue: 39/255, alpha: 1)}
    class var emailBlue: UIColor{UIColor(red: 1/255, green: 1/255, blue: 196/255, alpha: 1)}
    class var VeryLightGray : UIColor{UIColor(red: 228/255, green: 228/255, blue: 229/255, alpha: 1)}
    
}
