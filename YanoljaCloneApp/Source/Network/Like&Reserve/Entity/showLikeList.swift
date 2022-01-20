// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct showLikeList : Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeList]
}

// MARK: - Result
struct LikeList : Decodable {
    let id, user_id: Int
    let status: String
    let hotel_id: Int
    let hotel_name, notice, event: String
    let img_url: String
}
