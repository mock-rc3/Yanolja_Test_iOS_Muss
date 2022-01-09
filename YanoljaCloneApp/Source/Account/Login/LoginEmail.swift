//
//  LoginMain.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/08.
//

import Foundation
import UIKit

class LoginEmailView : BaseViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var PWButton: UITextField!
    @IBOutlet weak var IDButton: UITextField!
    @IBOutlet weak var EmailLoginBtn: UIView!
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        if let IDInfo = IDButton.text, let PWInfo = PWButton.text {
            // 로그인 정보 데이터베이스에서 조회하는 코드
            
        } else {return}
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
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
