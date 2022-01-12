//
//  LoginMain.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/08.
//

import Foundation
import UIKit

class LoginEmailView : BaseViewController, UITextFieldDelegate{
    
    lazy var dataManager : LoginDataManager = LoginDataManager()
    
    @IBOutlet weak var PWButton: UITextField!
    @IBOutlet weak var IDButton: UITextField!
    @IBOutlet weak var EmailLoginBtn: UIView!
    
    
    func LoginBtn() {
        if let IDInfo = IDButton.text, let PWInfo = PWButton.text {
            // 로그인 정보 데이터베이스에서 조회하는 코드
            
            EmailLoginBtn.backgroundColor = UIColor(red: 1/255, green: 128/255, blue: 97/255, alpha: 1)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            EmailLoginBtn.addGestureRecognizer(tapGesture)
            
        } else {
            EmailLoginBtn.backgroundColor = UIColor.darkGray
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            EmailLoginBtn.removeGestureRecognizer(tapGesture)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.IDButton.delegate = self
        self.PWButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.IDButton.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        LoginBtn()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        LoginBtn()
        return true
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if let IDInfo = IDButton.text, let PWInfo = PWButton.text{
            // 이메일 정보 데이터베이스에 저장하는 코드
            dataManager.LoginRequest(ID: IDInfo, PW: PWInfo, delegate: self)
            self.showIndicator()
        } else {return}
    }
    
}
extension LoginEmailView {
    func didRetrieveUserInfo(result : SignUpAndLogIn){
        if result.isSuccess{
            
            self.dismissIndicator()
            let MyPage = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "mypage") as! MyPageViewController
            MyPage.id = result.result.id
            MyPage.jwt = result.result.jwt
            
            self.changeRootViewController(MyPage)
            
        } else {
            self.dismissIndicator()
            self.presentAlert(title: result.message)
        }
        
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
