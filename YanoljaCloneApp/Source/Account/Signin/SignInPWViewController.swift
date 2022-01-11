//
//  SignInViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class SignInPWViewController : BaseViewController {
    
    var EmailInfo : String = ""

    
    @IBOutlet weak var PWReturnField: UITextField!
    @IBOutlet weak var PWReturnFieldCheck: UITextField!
    @IBOutlet weak var Next: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = .darkGray
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        Next.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if Next.backgroundColor == UIColor(red: 1/255, green: 129/255, blue: 96/255, alpha: 1), let PWInfo = PWReturnField.text {
            // 이메일 & 비밀번호 정보 데이터베이스에 저장하는 코드
            
            
            let NextPhase = self.storyboard?.instantiateViewController(withIdentifier: "third") as! SignInPHViewController
            NextPhase.email = EmailInfo
            NextPhase.password = PWInfo
            navigationController?.pushViewController(NextPhase, animated: true)
            
            
        } else {return}
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.PWReturnField.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        PWCheck()
        self.view.endEditing(true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PWCheck()
        textField.resignFirstResponder()
        return true
    }
    
    func PWCheck() {
        if let check = PWReturnField.text, let checkAgain = PWReturnFieldCheck.text {
            if check == checkAgain {
                Next.backgroundColor = UIColor(red: 1/255, green: 129/255, blue: 96/255, alpha: 1)
            } else {
                return
            }
        } else {
            return
        }
    }
    
}
