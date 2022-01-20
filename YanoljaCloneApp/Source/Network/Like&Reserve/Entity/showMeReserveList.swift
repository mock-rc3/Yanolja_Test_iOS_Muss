
import Foundation

// MARK: - Welcome
struct ReserveResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [[ReserveResult]]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseResult { response in
//     if let result = response.result.value {
//       ...
//     }
//   }

// MARK: - Result
struct ReserveResult: Codable {
    let roomBookingID: Int
    let bookingType: String
    let hotelID, roomID: Int
    let hotelName, roomName: String
    let imgURL: String
    let bookingStartDate, bookingEndDate: String
    let bookingStartTime, bookingEndTime, day, time: String?

    enum CodingKeys: String, CodingKey {
        case roomBookingID = "room_booking_id"
        case bookingType = "booking_type"
        case hotelID = "hotel_id"
        case roomID = "room_id"
        case hotelName = "hotel_name"
        case roomName = "room_name"
        case imgURL = "img_url"
        case bookingStartDate = "booking_start_date"
        case bookingEndDate = "booking_end_date"
        case bookingStartTime = "booking_start_time"
        case bookingEndTime = "booking_end_time"
        case day, time
    }
}
