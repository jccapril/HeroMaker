//
//  Login.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/24.
//

import Foundation
import RestfulClient
import Coder

class MobileSMSCodeRequest: BaseRequestable {
    let path: String = "/api/v1/sms"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(mobile: String) {
        body = try? JSONCoder.encode(object: ["mobile": mobile]).bytes
    }
}


class MobileSMSCodeAuthRequest: BaseRequestable {
    let path: String = "/api/v1/mobile/loginoregister"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(mobile: String, code: String) {
        body = try? JSONCoder.encode(object: ["mobile": mobile, "code": code]).bytes
    }
}


