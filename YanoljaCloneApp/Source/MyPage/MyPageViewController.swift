//
//  MyPageViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/11.
//

import Foundation

class MyPageViewController : BaseViewController {
    
    var id : String = ""
    var jwt : String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func NextView(_ sender: Any) {
        let RVC = self.storyboard?.instantiateViewController(withIdentifier: "reserveView")
        
        self.navigationController?.pushViewController(RVC!, animated: true)
    }
    
}
