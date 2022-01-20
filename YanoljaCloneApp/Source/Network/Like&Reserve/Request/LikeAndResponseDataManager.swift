//
//  LikeAndResponseDM.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/19.
//

import Foundation
import Alamofire
import UIKit

class LikeAndReserveDataManager : UIViewController {
    
    func likeHotel(hotel_id : Int, delegate : SpecificRestViewController) {
        
        let url = "http://\(Constant.BASE_URL)"
                + "/like/\(Constant.user_id)"
            
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN" : Constant.jwt
        ]
        
        let body : [String : Int] = [
            "hotel_id" : hotel_id
        ]
        
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: LikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetreiveLikeInfo(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequestLikeId(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func showMeLikeList(delegate : HeartViewController) {
        let url = "http://\(Constant.BASE_URL)"
                + "/like"
        
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN" : Constant.jwt
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: showLikeList.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetreiveLikeList(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func deleteLikeItem(delegate : SpecificRestViewController) {
        let url = "http://\(Constant.BASE_URL)"
                + "/like"
                + "?userId=\(Constant.user_id)"
                + "&likeId=\(Constant.likeId)"
        
        let body : [String : Int] = [
            "status" : 0
        ]
        
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN" : Constant.jwt
        ]
        
        AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: DeleteLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.deleteSuccess(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
}
