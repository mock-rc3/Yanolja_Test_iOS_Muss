// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - LikeResponse
struct LikeResponse : Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LikeResult
}

// MARK: - Result
struct LikeResult : Decodable {
    let id: Int
}

struct DeleteLikeResponse : Decodable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : String
}
