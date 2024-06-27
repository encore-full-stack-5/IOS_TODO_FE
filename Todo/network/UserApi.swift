//
//  UserApi.swift
//  Todo
//
//  Created by 안홍범 on 6/22/24.
//

import Alamofire
import Foundation

// MARK: - UserSignupModel
struct UserSignup: Codable{
    // 회원가입 이메일, 비밀번호, 비밀번호 확인, 닉네임, 공개여부 설정
    let email : String
    let password :String
    let passwordCheck: String
    let nickname:String
    let userPublicScope: Bool
}

// MARK: - UserSignupApi
class UserSignupNetworkManager{
    
    static let UserSignupApi = UserSignupNetworkManager()
    private init() {}
    let host = "34.69.5.209:30008" // 추후 수정(GCP)
    
    
}
