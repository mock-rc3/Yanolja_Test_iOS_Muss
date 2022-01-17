// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct SpecificResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Result
}

// MARK: - Result
struct Result : Decodable {
    var hotelImg: [String]
    var hotelInfo: HotelInfo
    var roomList: [RoomList]
    var convenience: [resultConvenience]
    var hotelRule: [HotelRule]
    var reviewScore: ReviewScore
    var reviewList: [ReviewList]
    var reviewReply: [ReviewReply]
}

// MARK: - HotelInfo
struct HotelInfo : Decodable{
    var hotelName, rating, sumReview, sumReply: String
    var locationMemo: String
}

struct RoomList : Decodable{
    var roomId : Int
    var roomImg : String
    var roomName : String
    var roomMemo : String
    var minPersonnel : String
    var maxPersonnel : String
    var timeUse : String
    var timePercent : Int
    var timePrice : String
    var timeSale : String
    var sleepCheckin : String
    var sleepPercent : Int
    var sleepPrice : String
    var sleepSale : String
}

// MARK: - HotelRule
struct HotelRule : Decodable{
    var ruleTitle, ruleContent: String
}

// MARK: - Convenience
struct resultConvenience : Decodable{
    var cvImg: String
    var cvTitle: String
}

// MARK: - ReviewList
struct ReviewList : Decodable{
    var reviewId : String
    var avgScore : String?
    var nickname : String
    var roomName: String
    var reviewContent : String?
    var createDate: String
}

// MARK: - ReviewReply
struct ReviewReply : Decodable{
    var reviewId, replyContent, createDate: String
}

// MARK: - ReviewScore
struct ReviewScore : Decodable{
    var avgKind, avgClean, avgComfort, avgInventory: String
}
