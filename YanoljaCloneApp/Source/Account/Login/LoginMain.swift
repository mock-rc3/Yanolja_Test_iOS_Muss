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
    @IBOutlet weak var PhoneLoginBtn: UIView!
    @IBOutlet weak var SIgininBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailLoginBtn.backgroundColor = .white
        PhoneLoginBtn.backgroundColor = .white
        EmailLoginBtn.layer.borderWidth = 1
        PhoneLoginBtn.layer.borderWidth = 1
        EmailLoginBtn.layer.borderColor = UIColor.black.cgColor
        PhoneLoginBtn.layer.borderColor = UIColor.black.cgColor
        
        SIgininBtn.titleLabel?.font = .NotoSans(.medium, size: 17)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        EmailLoginBtn.addGestureRecognizer(tapGesture)


    }
    
    
    @IBAction func KakaoLoginBtn(_ sender: Any) {
        dataManager.KakaoLogin()
    }
    
    @IBAction func NaverLoginBtn(_ sender: Any) {
        dataManager.NaverLogin()
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        let LoginEmailView = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginemailview")
        navigationController?.pushViewController(LoginEmailView, animated: true)
        
    }

    
}




