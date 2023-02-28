//
//  APICenter.API.Couple.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/28.
//

public extension APICenter {
    enum Couple {}
}

public extension APICenter.Couple {
    // 获取情侣信息
    static func getCoupleInfo() async throws -> CoupleInfo? {
        let request = CoupleInfoRequest()
        return try await APICenter.execute(request)
    }
    
    // 获取情侣邀请码
    static func getInvitationCode() async throws -> String? {
        let request = CoupleInvitationRequest()
        return try await APICenter.execute(request)
    }
    
    // 获取情侣邀请码
    static func getCoupleUser(code: String) async throws -> UserInfo? {
        let request = CoupleUserRequest(code: code)
        return try await APICenter.execute(request)
    }
    
    // 绑定情侣
    static func bindCouple(code: String, guid: String) async throws  {
        let request = BindCoupleRequest(code: code, guid: guid)
        let _: NullResponse? =  try await APICenter.execute(request)
    }
}

