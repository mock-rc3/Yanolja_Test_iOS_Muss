//
//  RestListResponse.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/14.
//

import Foundation

struct RestListResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : Info
}
struct Info : Decodable {
    var areaInfo : [LocationInfo]
    var hotelList : [ListInfo]
}
struct LocationInfo : Decodable {
    var location : String
    var startDate : String
    var endDate : String
    var personnel : String
}
struct ListInfo : Decodable {
    var hotelId : String
    var imgUrl : String
    var hotelName : String
    var locationMemo : String
    var rating : String?
    var sumReview : String
    var timePercent : Int
    var timeUse : String?
    var timePrice : String
    var timeSale : String
    var sleepPercent : Int
    var sleepStart : String?
    var sleepPrice : String
    var sleepSale : String
    var event : String
}
