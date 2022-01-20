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
    
    
    func reserveTime(hotel_id : Int, room_id : Int, startTime : String, endTime : String, price : String, delegate : timeReserveViewController) {
        
        let url = "http://\(Constant.BASE_URL)"
                + "/booking/time"
        
        let body : [String : Any] = [
            "user_id" : 1,
            "hotel_id" : hotel_id,
            "room_id" : room_id,
            "booking_type" : "T",
            "payment_id" : 3,
            "booking_start_date" : "20220115",
            "booking_end_date" : "20220116",
            "booking_start_time" : "1400",
            "booking_end_time" : "1800",
            "room_final_price" : price
        ]
        
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: RoomReserveResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetreiveReserveInfo(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func reserveSleep(hotel_id : Int, room_id : Int, startTime : String, endTime : String, price : String, delegate : sleepReserveViewController) {
        
        let url = "http://\(Constant.BASE_URL)"
                + "/booking/sleep"
        
        let body : [String : Any] = [
            "user_id" : 1,
            "hotel_id" : hotel_id,
            "room_id" : room_id,
            "booking_type" : "T",
            "payment_id" : 3,
            "booking_start_date" : "20220115",
            "booking_end_date" : "20220116",
            "room_final_price" : price
        ]
        
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: RoomReserveResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetreiveSleepInfo(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToSleepRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func showMeReserveList(delegate : ReserveViewController) {
        let url = "http://\(Constant.BASE_URL)"
        + "/booking/1"
        
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY0MjU3MDQ0NSwiZXhwIjoxNjQ0MDQxNjc0fQ.xmc-Ab2GOovrgaB6ML7e-1wyFKowkcP5_pAy2rxcHTU"
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ReserveResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetreiveReserveList(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func deleteReservedRoom(userId : String, reserveId : Int, delegate : ReserveViewController) {
        let url = "http://\(Constant.BASE_URL)"
                + "/order-cancel/\(Constant.user_id)"
                + "?bookingType=T"
                + "&roomBookingId=\(reserveId)"
        
        let header : HTTPHeaders = [
            "X-AUTH-TOKEN" : Constant.jwt
        ]
        
        let body : [String : String] = [
            "status" : "0"
        ]
        
        AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: DeleteReserveResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didDeleteReservation(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToDelete(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
        
    }
    
}
