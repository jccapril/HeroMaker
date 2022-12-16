//
//  RegisterRequest.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/16.
//

import Foundation
import RestfulClient
import Coder

class RegisterRequest: BaseRequestable {
    let path: String = "/api/v1/auth/register"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(name: String, mobile: String, password: String) {
        body = try? JSONCoder.encode(object: ["name": name,"mobile": mobile, "password": password]).bytes
    }
}

