//
//  BindProvider.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import Center
import Foundation
import UICore

class BindProvider: Provider {}


extension BindProvider {
    
    func getCode() async throws -> String? {
        try await APICenter.Couple.getInvitationCode()
    }
    
    func getCoupleUser(code: String) async throws -> UserInfo? {
        try await APICenter.Couple.getCoupleUser(code: code)
    }
    

    func bind(code: String, guid: String) async throws {
        try await APICenter.Couple.bindCouple(code: code, guid: guid)
        try await UserCenter.getCoupleInfo()
    }
}


