//
//  LoginNetwork.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/09.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire


class LoginDataManager : UIViewController {
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    func KakaoLogin() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
               print("loginWithKakaoAccount() success.")
               //do something
               _ = oauthToken
               
               // 엑세스토큰
               let accessToken = oauthToken?.accessToken
               
               //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
               self.getKakaoInfo()
           }
        }
    }
    
    func getKakaoInfo() {
        //사용자 관리 api 호출
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                 
                
                if let userNickname = user?.kakaoAccount?.profile?.nickname{
                    print(userNickname)
                
                    Constant.ud.set(userNickname, forKey: "name")
                    Constant.ud.set(true, forKey: "loginCheck")

                } else {
                    
                    print("couldn't load the nickname")
                    Constant.ud.set("방문자", forKey: "name")
                    Constant.ud.set(false, forKey: "loginCheck")
                }
                
                //마이페이지 화면으로 전환
                
                
            }
        }
    }
    
    func NaverLogin() {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    func getNaverInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
          return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
        
            Constant.ud.set(name, forKey: "name")
            Constant.ud.set(true, forKey: "loginCheck")
        }
    }
    
    
    func LoginRequest(ID: String, PW: String, delegate: LoginEmailView) {
        let url = "http://\(Constant.BASE_URL)"
            + "/login"
        
        let parameters : [String : String] = [
            "email" : ID,
            "password" : PW
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: SignUpAndLogIn.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveUserInfo(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
}



extension LoginDataManager: NaverThirdPartyLoginConnectionDelegate {
    // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
    //     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
    //     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
    //     present(naverSignInVC, animated: false, completion: nil)
    }

    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    getNaverInfo()
    }

    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {

    }

    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
    }

    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
    }
}


