//
//  RoomResponse.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/17.
//

import Foundation

// MARK: - RoomResponse
struct RoomResponse : Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: RoomResult
}

// MARK: - Result
struct RoomResult : Decodable {
    let roomImg: [String?]
    let roomInfo: RoomInfo
}

// MARK: - RoomInfo
struct RoomInfo : Decodable {
    let roomId : Int
    let roomName, roomMemo, minPersonnel, maxPersonnel: String
    let hotelName, timeUse, timeStart, timeEnd: String
    let timePrice, timeSale: String
    let timePercent: Int
    let sleepCheckIn, sleepCheckOut, sleepPrice, sleepSale: String
    let sleepPercent: Int
}
