//
//  SignInDataManager.swift
//  YanoljaCloneApp
//
//  Created by 정지윤 on 2022/01/10.
//
//

import Foundation


struct EmailAuthResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}

