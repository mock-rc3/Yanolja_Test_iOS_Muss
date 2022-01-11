//
//  SignInViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class SignInPHViewController : BaseViewController {
    
    lazy var dataManager : SignInDataManeger = SignInDataManeger()
    
    var message : String = ""
    var sentCount : Int = 5
    var PHInfo : String = ""
    
    var email : String = ""
    var password :String = ""
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
    let secondTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondHandleTap(sender:)))
    
    @IBOutlet weak var PhoneNumTextField: UITextField!
    @IBOutlet weak var AuthNumTextField: UITextField!
    @IBOutlet weak var AuthNumTitle: UILabel!
    @IBOutlet weak var SendAuthNumBtn: UIView!
    @IBOutlet weak var SendAuthNumTitle: UILabel!
    @IBOutlet weak var Complete: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = .darkGray
        
        PhoneNumTextField.layer.borderWidth = 1
        PhoneNumTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        SendAuthNumBtn.addGestureRecognizer(tapGesture)
        
        
        // 처음엔 인증번호 입력 코드와 완료 버튼 안보이게 한다
        AuthNumTitle.isHidden = true
        AuthNumTextField.isHidden = true
        Complete.isHidden = true
        
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        print("phone tapped")
        
        if let phInfo = PhoneNumTextField.text {
            
            PHInfo = phInfo
            dataManager.PhoneAuthCheck(phoneNumber: phInfo, delegate: self)
            self.showIndicator()
            
        } else {return}
        
        
    }
    
    @objc func secondHandleTap(sender: UITapGestureRecognizer) {
        
        print("complete tapped")
        
        if let check = AuthNumTextField.text, let num = PhoneNumTextField.text {
            dataManager.PhoneAuthNumCheck(authNum: check, phoneNumber: num, delegate: self)
            self.showIndicator()
            
        } else {return}
        
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        self.PhoneNumTextField.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        if AuthNumTitle.isHidden {
            return
        } else{
            authCodeCorrectForm()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if !AuthNumTitle.isHidden {
            authCodeCorrectForm()
        }
        
        return true
    }
    
    //인증번호 재전송 뷰로 전환
    func viewChanged(){
        SendAuthNumBtn.backgroundColor = .white
        SendAuthNumBtn.layer.borderWidth = 1
        SendAuthNumBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        SendAuthNumTitle.textColor = .black
        SendAuthNumTitle.text = "인증번호 재전송 (남은 횟수 \(sentCount)회)"
        
    }
    
    //인증번호 제대로 적었는지 확인
    func authCodeCorrectForm() {
        
        if let authCode = AuthNumTextField.text{
            if authCode.count == 8{
                Complete.backgroundColor = UIColor(red: 1/255, green: 128/255, blue: 97/255, alpha: 1)
                let secondTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondHandleTap(sender:)))
                Complete.addGestureRecognizer(secondTapGesture)
            } else {
                Complete.backgroundColor = UIColor.lightGray
                Complete.removeGestureRecognizer(secondTapGesture)
                
                return
            }
        }
    }
    
}


extension SignInPHViewController {
    func didRetrievePHAuthCheck (result : AuthResponse){
        switch result.code{
        case 1000:
            self.dismissIndicator()
            
            message = "인증번호가 발송되었습니다."
            sentCount = sentCount - 1
            if sentCount != -1 {
                viewChanged()
                
                // 인증번호 발송하면 인증번호 입력창과 다음 버튼 보이게 한다.
                AuthNumTitle.isHidden = false
                AuthNumTextField.isHidden = false
                Complete.isHidden = false
                self.presentAlert(title: message)
                
            } else{
                SendAuthNumTitle.text = "인증번호를 더 이상 보낼 수 없습니다."
                SendAuthNumBtn.removeGestureRecognizer(tapGesture)
            }
        default:
            message = "이메일을 다시 입력하세요."
            self.presentAlert(title: message)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension SignInPHViewController {
    func didRetrievePHAuthNum (result : AuthResponse) {
        if result.isSuccess {
            self.dismissIndicator()
            //핸드폰 인증번호 성공 시에
            dataManager.StoreUserInfo(email: email, phoneNumber: PHInfo, password: password, delegate: self)
            self.showIndicator()
            
        } else {
            message = "\(result.message)"
            self.presentAlert(title: message)
        }
    }
}

extension SignInPHViewController {
    func didStoreUserInfo (result : SignUpAndLogIn) {
        if result.isSuccess {
            self.dismissIndicator()
            
            let NextPhase = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "mypage") as! MyPageViewController
            
            NextPhase.id = result.result.id
            NextPhase.jwt = result.result.jwt
        
            self.changeRootViewController(NextPhase)
            
        } else {
            message = "\(result.message)"
            self.presentAlert(title: message)
        }
    }
}

