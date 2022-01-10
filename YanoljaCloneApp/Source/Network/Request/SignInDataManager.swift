//
//  SignInDataManager.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/10.
//

import Foundation
import Alamofire

class SignInDataManeger : UIViewController {
    
    
    func EmailAuthCheck(email: String, delegate: SignInViewController) {
        let url = "\(Constant.BASE_URL)"
            + "/email-auth"
        
        let login = ["email" : "\(email)"] as Dictionary
        
        AF.request(url, method: .post, parameters: login, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: EmailAuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveEmailAuthCheck(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func EmailAuthNumCheck(authNum: String, delegate: SignInViewController) {
        let url = "\(Constant.BASE_URL)"
            + "/email-confirm"
        
        let auth = ["authNumber" : "\(authNum)"] as Dictionary
        
        AF.request(url, method: .post, parameters: auth, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: EmailAuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveEmailAuthNum(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    
    
    
}
