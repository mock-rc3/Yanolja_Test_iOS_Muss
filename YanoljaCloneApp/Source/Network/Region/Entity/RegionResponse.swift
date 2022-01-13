//
//  RegionResponse.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/13.
//

import Foundation

struct RegionResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : Map
}

struct Map : Decodable {
    var mainArea : Array<String>
    var subArea : Array<String>
}
