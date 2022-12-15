//
//  UserInfoRequest.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/15.
//

import Foundation
import RestfulClient
import Coder

class UserInfoRequest: BaseRequestable {
    let path: String = "/api/v1/user/info"
    let method: HTTPMethod = .POST
}

