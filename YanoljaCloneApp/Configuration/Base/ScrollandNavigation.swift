//
//  ScrollandNavigation.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class ScrollandNavigation: BaseViewController, UIScrollViewDelegate {
    var lastContentOffset: CGFloat = 0.0
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (self.lastContentOffset <= 0 || self.lastContentOffset > scrollView.contentOffset.y) {
            self.navigationController?.navigationBar.isHidden = false
        }
        
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            self.navigationController?.navigationBar.isHidden = true
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
        
    }
    
    
}
