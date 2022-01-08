//
//  LoginMain.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/08.
//

import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire



class LoginMainView : BaseViewController{
    
    lazy var dataManager : LoginDataManager = LoginDataManager()
    
    @IBOutlet weak var EmailLoginBtn: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func KakaoLoginBtn(_ sender: Any) {
        
        
    }
    
    @IBAction func NaverLoginBtn(_ sender: Any) {
        
        
    }
    
    
    @IBAction func SignInBtn(_ sender: Any) {
    }
    
    

    
}
    



