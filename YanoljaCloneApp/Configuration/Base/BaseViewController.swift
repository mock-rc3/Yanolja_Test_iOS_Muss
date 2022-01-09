//
//  AppDelegate.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/08.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 아래 예시들처럼 상황에 맞게 활용하시면 됩니다.
        // Navigation Bar
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.NotoSans(.medium, size: 16),
        ]
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = .black
        
        // Background Color
        self.view.backgroundColor = .white
    }
}
