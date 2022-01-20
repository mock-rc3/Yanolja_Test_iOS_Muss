//
//  SignInDataManager.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/10.
//

import Foundation
import Alamofire

class SignInDataManeger : UIViewController {
    
    //이메일 인증번호 요청
    func EmailAuthCheck(email: String, delegate: SignInViewController) {
        let url = "http://\(Constant.BASE_URL)"
            + "/auth/email"
        
        let parameters = ["authMethod" : email] as Dictionary
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveEmailAuthCheck(result: response)
                case .failure(let error):
                    print(url)
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //이메일 인증번호 응답
    func EmailAuthNumCheck(authNum: String, email : String, delegate: SignInViewController) {
        let url = "http://\(Constant.BASE_URL)"
            + "/auth/email-confirm"
        
        let parameters : [String : String] = [
            "authNumber" : authNum,
            "authMethod" : email
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: AuthNumResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveEmailAuthNum(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //핸드폰 인증번호 요청
    func PhoneAuthCheck(phoneNumber: String, delegate: SignInPHViewController) {
        let url = "http://\(Constant.BASE_URL)"
            + "/auth/phone"
        
        let parameters = ["authMethod" : phoneNumber] as Dictionary
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrievePHAuthCheck(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //핸드폰 인증번호 응답 - GET 방식
    func PhoneAuthNumCheck(authNum: String, phoneNumber: String, delegate: SignInPHViewController) {
        let url = "http://\(Constant.BASE_URL)"
            + "/auth/phone-confirm"
        
        let parameters : [String : String] = [
            "authMethod" : phoneNumber,
            "authNumber" : authNum
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrievePHAuthNum(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //데이터베이스에 정보저장
    func StoreUserInfo(email: String, phoneNumber: String, password: String ,delegate: SignInPHViewController) {
        let url = "http://\(Constant.BASE_URL)"
            + "/sign-up"
        
        let parameters : [String : String] = [
            "email" : email,
            "phoneNumber" : phoneNumber,
            "password" : password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: SignUpAndLogIn.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didStoreUserInfo(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
