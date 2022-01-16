//
//  SpecificDataManager.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/15.
//

import Foundation
import UIKit
import Alamofire

class SpecificDataManager : UIViewController{
    
    func requestSpecificRestList(startDate : String, endDate : String, days : String, hotelId : Int, delegate : SpecificRestViewController) {
        
        let url = "http://\(Constant.BASE_URL)"
            + "/hotel/:hotelId/\(hotelId)"
            + "?startDate=\(startDate)"
            + "&endDate=\(endDate)"
            + "&days=\(days)"
        
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: SpecificResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("SUCCESS")
                    delegate.didRetrieveRestList(result: response)
                case .failure(let error):
                    print(error)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
        
    }
}
