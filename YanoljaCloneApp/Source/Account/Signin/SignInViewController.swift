//
//  SignInViewController.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import UIKit

class SignInViewController : BaseViewController {
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var EmailEnterView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailEnterView.backgroundColor = .white
        EmailEnterView.layer.borderWidth = 1
        EmailEnterView.layer.borderColor = UIColor(red: 1/255, green: 1/255, blue: 196/255, alpha: 1).cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        EmailEnterView.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if let EmailInfo = EmailTextField.text {
            // 이메일 정보 데이터베이스에 저장하는 코드
            
            
            let NextPhase = self.storyboard?.instantiateViewController(withIdentifier: "second") as! SignInPWViewController
            NextPhase.EmailInfo = EmailInfo
            navigationController?.pushViewController(NextPhase, animated: true)
            
            
        } else {return}
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.EmailTextField.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
