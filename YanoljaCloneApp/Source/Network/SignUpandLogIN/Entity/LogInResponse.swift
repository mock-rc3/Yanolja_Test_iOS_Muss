//
//  SignInDataManager.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/10.
//
//

import Foundation


struct AuthResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}


struct AuthNumResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}

struct SignUpAndLogIn : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : Token
}

struct Token : Decodable {
    var id : String
    var jwt : String
}

