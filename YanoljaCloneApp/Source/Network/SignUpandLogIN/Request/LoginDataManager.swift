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
    
    var accessToken : String?
    var refreshToken : String?
    
    
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
               
               if let access = oauthToken?.accessToken, let refresh = oauthToken?.refreshToken{
                   
                   print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                   print(access)
                   print(refresh)
                   
                   self.accessToken = access
                   self.refreshToken = refresh
                   
               } else {
                   print("토큰 값이 존재하지 않습니다")
                   return
               }
               
               
               
               //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
               self.getKakaoInfo()
           }
        }
    }
    
    
    //인가토큰 및 리프레쉬토큰 서버에 전달
    func sendKakaoInfo(auth : String, refresh : String) {
        let url = "http://\(Constant.BASE_URL)"
            + "/login/kakao"
            + "?accessToken=" + auth
            + "&refreshToken=" + refresh
        
        print(url)
        
        
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded){
        
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: SignUpAndLogIn.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.isSuccess{
                            
                            print(response.message)
                            let NextPhase = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "mypage") as! MyPageViewController
                            
                            self.present(NextPhase, animated: true)
                        }
                    case .failure(let error):
                        print("failed!!")
                        print(error)
                    }
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
                if let access = self.accessToken, let refresh = self.refreshToken {
                    self.sendKakaoInfo(auth: access, refresh: refresh)
                }
                
            }
        }
    }
    
    func NaverLogin() {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    func sendNaverInfo(auth : String, refresh : String) {
        let url = "http://\(Constant.BASE_URL)"
            + "/login/naver"
        
        let parameters : [String : String] = [
            
            "accessToken" : auth,
            "refreshToken" : refresh
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: SignUpAndLogIn.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess{
                        
                        print(response.message)
                        let NextPhase = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "mypage") as! MyPageViewController
                        
                        self.present(NextPhase, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getNaverInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
          return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        guard let refreshToken = loginInstance?.refreshToken else { return }
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
            
            self.sendNaverInfo(auth: accessToken, refresh: refreshToken)
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


