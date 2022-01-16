//
//  RegionDataManager.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/13.
//

import Foundation
import Alamofire

class RegionDataManager : UIViewController{
    
    func InquireRegion(delegate: RegionViewController) {
        let url = "http://\(Constant.BASE_URL)"
            + "/area"
        
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: RegionResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetrieveRegionInfo(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func RequestRestList(days : String, areadId : Int, delegate : RestListViewController) {
        
        let url = "http://\(Constant.BASE_URL)"
            + "/area/:areadId/\(areadId)"
            + "?days=\(days)"
        
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: RestListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetrieveHotelList(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
        
    }
    
}
