//
//  SignInViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class SignInViewController : BaseViewController {
    
    
    lazy var dataManager : SignInDataManeger = SignInDataManeger()
    
    var message : String = ""
    var sentCount : Int = 5
    var emailInfo : String = ""
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
    let secondTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondHandleTap(sender:)))
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var AuthCodeTransmit: UIView!
    @IBOutlet weak var AuthCodeTransmitLabel: UILabel!
    @IBOutlet weak var AuthCodeTitle: UILabel!
    @IBOutlet weak var AuthCodeEnter: UITextField!
    @IBOutlet weak var NextView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = .darkGray
        
        AuthCodeTransmit.backgroundColor = .white
        AuthCodeTransmit.layer.borderWidth = 1
        AuthCodeTransmit.layer.borderColor = UIColor(red: 1/255, green: 1/255, blue: 196/255, alpha: 1).cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        AuthCodeTransmit.addGestureRecognizer(tapGesture)
        
        
        // 처음엔 인증번호 입력 코드와 다음 버튼 안보이게 한다
        AuthCodeTitle.isHidden = true
        AuthCodeEnter.isHidden = true
        NextView.isHidden = true
        
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        print("first tapped")
        
        if let EmailInfo = EmailTextField.text {
            // 이메일 정보 데이터베이스에 저장하는 코드
            emailInfo = EmailInfo
            dataManager.EmailAuthCheck(email: emailInfo, delegate: self)
            self.showIndicator()
            
        } else {return}
        
        
    }
    
    @objc func secondHandleTap(sender: UITapGestureRecognizer) async {
        
        print("second tapped")
        
        if let check = AuthCodeEnter.text {
            dataManager.EmailAuthNumCheck(authNum: check, email: emailInfo, delegate: self)
            self.showIndicator()
            
        } else {return}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.EmailTextField.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        authCodeCorrectForm()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        authCodeCorrectForm()
        return true
    }
    
    //인증번호 재전송 뷰로 전환
    func viewChanged(){
        AuthCodeTransmit.backgroundColor = .white
        AuthCodeTransmit.layer.borderWidth = 1
        AuthCodeTransmit.layer.borderColor = UIColor.lightGray.cgColor
        
        AuthCodeTransmitLabel.textColor = .black
        AuthCodeTransmitLabel.text = "인증번호 재전송 (남은 횟수 \(sentCount)회)"
    }
    
    //인증번호 제대로 적었는지 확인
    func authCodeCorrectForm() {
        
        if let authCode = AuthCodeEnter.text{
            if authCode.count == 4{
                NextView.backgroundColor = UIColor(red: 1/255, green: 128/255, blue: 97/255, alpha: 1)
                let secondTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondHandleTap(sender:)))
                NextView.addGestureRecognizer(secondTapGesture)
            } else {
                NextView.backgroundColor = UIColor.lightGray
                NextView.removeGestureRecognizer(secondTapGesture)
                
                return
            }
        }
    }
}


extension SignInViewController {
    func didRetrieveEmailAuthCheck (result : AuthResponse){
        switch result.code{
        case 1000:
            self.dismissIndicator()
            
            message = "인증번호가 발송되었습니다."
            sentCount = sentCount - 1
            if sentCount != -1 {
                viewChanged()
                
                // 인증번호 발송하면 인증번호 입력창과 다음 버튼 보이게 한다.
                AuthCodeEnter.isHidden = false
                AuthCodeTitle.isHidden = false
                NextView.isHidden = false
                self.presentAlert(title: message)
                
            } else{
                AuthCodeTransmitLabel.text = "인증번호를 더 이상 보낼 수 없습니다."
                AuthCodeTransmit.removeGestureRecognizer(tapGesture)
            }
        default:
            message = result.message
            self.presentAlert(title: message)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension SignInViewController {
    func didRetrieveEmailAuthNum (result : AuthResponse) {
        if result.isSuccess {
            self.dismissIndicator()
            let NextPhase = self.storyboard?.instantiateViewController(withIdentifier: "second") as! SignInPWViewController
            NextPhase.EmailInfo = emailInfo
            navigationController?.pushViewController(NextPhase, animated: true)
            
        } else {
            message = "\(result.message)"
            self.presentAlert(title: message)
        }
    }
}
