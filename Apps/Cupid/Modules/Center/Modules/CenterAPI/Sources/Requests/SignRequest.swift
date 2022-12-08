//
//  PasswordSignRequest.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/8.
//

import Foundation
import RestfulClient
import Coder

class SignRequest: BaseRequestable {
    let path: String = "/api/auth/login"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(username: String, password: String) {
        body = try? JSONCoder.encode(object: ["mobile": username, "password": password]).bytes
    }
}
