//
//  PasswordSignRequest.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/8.
//

import Foundation
import RestfulClient
import Coder

class MobilePasswordAuthRequest: BaseRequestable {
    let path: String = "/api/v1/auth/login"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(mobile: String, password: String) {
        body = try? JSONCoder.encode(object: ["mobile": mobile, "password": password]).bytes
    }
}
